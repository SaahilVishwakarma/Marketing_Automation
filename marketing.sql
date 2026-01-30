-- Create ENUM type for content_type
CREATE TYPE content_type_enum AS ENUM ('Festival', 'Weekly Post', 'Meme', 'Custom Template');

-- Create ENUM type for status
CREATE TYPE status_enum AS ENUM ('Pending', 'Approved', 'Rejected');

-- Create ENUM type for post_platforms
CREATE TYPE post_platforms_enum AS ENUM ('LinkedIn', 'Twitter', 'Instagram', 'Facebook'); -- You can modify the platforms as needed

CREATE TABLE content_calendar (
    content_id SERIAL PRIMARY KEY,
    content_type content_type_enum NOT NULL,
    scheduled_date DATE NOT NULL,
    status status_enum NOT NULL,
    approval_date DATE,
    approval_feedback TEXT,
    post_platforms post_platforms_enum[],  -- Enum array for platforms
    content_text TEXT,
    generated_images TEXT
);


-- Create ENUM type for content_type
CREATE TYPE content_type_enum AS ENUM ('Festival', 'Weekly Post', 'Meme', 'Custom Template');

-- Create ENUM type for status
CREATE TYPE status_enum AS ENUM ('Pending', 'Approved', 'Rejected');

CREATE TABLE content_library (
    content_id SERIAL PRIMARY KEY,
    content_type content_type_enum NOT NULL,
    content_media TEXT,
    content_caption TEXT,
    status status_enum NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prompt_used TEXT
);

-- Create ENUM type for content_status
CREATE TYPE content_status_enum AS ENUM ('Pending', 'Approved', 'Published');


CREATE TABLE weekly_posts (
    post_id SERIAL PRIMARY KEY,
    topic VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    content_status content_status_enum NOT NULL,  -- Use the ENUM type here
    generated_content TEXT,
    generated_images TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE content_edit_history (
    edit_id SERIAL PRIMARY KEY,
    content_id INT REFERENCES content_library(content_id) ON DELETE CASCADE,
    edited_by INT, -- Assuming User table exists with user_id
    old_content TEXT,
    new_content TEXT,
    edit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    change_description TEXT
);
CREATE TABLE custom_templates (
    template_id SERIAL PRIMARY KEY,
    template_name VARCHAR(255) NOT NULL,
    template_description TEXT,
    prompt_structure TEXT,
    image_description TEXT,
    file_attachments TEXT[],  -- Store URLs to files (e.g., logos)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create ENUM type for platform
CREATE TYPE platform_enum AS ENUM ('LinkedIn', 'Twitter', 'Instagram', 'Facebook'); -- You can extend this list with other platforms if needed

CREATE TABLE social_posts (
    post_id SERIAL PRIMARY KEY,
    content_id INT REFERENCES content_library(content_id) ON DELETE CASCADE,
    platform platform_enum,  -- Use the ENUM type here
    post_url TEXT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    impressions INT DEFAULT 0,
    likes INT DEFAULT 0,
    comments INT DEFAULT 0,
    shares INT DEFAULT 0,
    engagement_rate FLOAT
);




-- Create ENUM type for ai_tool_used
CREATE TYPE ai_tool_enum AS ENUM ('Gemini', 'ChatGPT', 'DALL-E', 'Imgflip');

CREATE TABLE content_generation_logs (
    generation_id SERIAL PRIMARY KEY,
    content_type content_type_enum NOT NULL,  -- Use the ENUM type here
    status status_enum NOT NULL,              -- Use the ENUM type here
    generated_content TEXT,
    generated_media TEXT,
    ai_tool_used ai_tool_enum NOT NULL,      -- Use the ENUM type here
    prompt_description TEXT,
    generation_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Create ENUM type for approval_status
CREATE TYPE approval_status_enum AS ENUM ('Approved', 'Rejected');

CREATE TABLE approval_logs (
    approval_id SERIAL PRIMARY KEY,
    content_id INT REFERENCES content_library(content_id) ON DELETE CASCADE,
    approver_id INT,  -- Assuming User table exists with user_id
    approval_status approval_status_enum,  -- Use the ENUM type here
    feedback TEXT,
    approval_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Create ENUM type for task_status
CREATE TYPE task_status_enum AS ENUM ('Scheduled', 'Executed', 'Failed');

-- Create ENUM type for task_type
CREATE TYPE task_type_enum AS ENUM ('Festival', 'Knowledge Drop', 'Meme', 'Achievement');

-- Create ENUM type for post_platform
CREATE TYPE post_platform_enum AS ENUM ('LinkedIn', 'Twitter', 'Instagram');

CREATE TABLE n8n_scheduler_logs (
    task_id SERIAL PRIMARY KEY,
    content_id INT REFERENCES content_library(content_id) ON DELETE CASCADE,
    task_status task_status_enum,  -- Use the ENUM type here
    task_type task_type_enum,      -- Use the ENUM type here
    execution_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    post_platform post_platform_enum  -- Use the ENUM type here
);




-- Create ENUM type for activity_type
CREATE TYPE activity_type_enum AS ENUM ('Created', 'Edited', 'Approved', 'Rejected');

CREATE TABLE user_activity_logs (
    activity_id SERIAL PRIMARY KEY,
    user_id INT, -- Assuming User table exists with user_id
    content_id INT REFERENCES content_library(content_id) ON DELETE CASCADE,
    activity_type activity_type_enum,  -- Use the ENUM type here
    activity_description TEXT,
    activity_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




