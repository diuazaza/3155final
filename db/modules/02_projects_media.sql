-- =============================================================================
-- PROJECTS & MEDIA MODULE
-- Owner: Ayush
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Projects
-- Stores the main information for projects shared by users.
-- -----------------------------------------------------------------------------

CREATE TABLE projects (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    user_id INT NOT NULL
        REFERENCES users(id)
        ON DELETE CASCADE,

    title VARCHAR(150) NOT NULL,

    description TEXT NOT NULL,

    project_url VARCHAR(512),

    is_seeking_collaborators BOOLEAN DEFAULT FALSE NOT NULL,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


-- -----------------------------------------------------------------------------
-- Project Media
-- Stores media attached to projects, such as images, videos, audio, or documents.
-- The actual files can later be stored in object storage such as S3.
-- -----------------------------------------------------------------------------

CREATE TABLE project_media (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    project_id INT NOT NULL
        REFERENCES projects(id)
        ON DELETE CASCADE,

    media_url VARCHAR(512) NOT NULL,

    media_type VARCHAR(20) NOT NULL
        CHECK (
            media_type IN (
                'image',
                'video',
                'audio',
                'document'
            )
        ),

    display_order INT DEFAULT 0 NOT NULL,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


-- -----------------------------------------------------------------------------
-- Tags
-- Lookup table containing project categories/tags.
-- Examples: Game Development, Crafts, Beginner.
-- -----------------------------------------------------------------------------

CREATE TABLE tags (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(50) UNIQUE NOT NULL
);


-- -----------------------------------------------------------------------------
-- Project Tags
-- Junction table creating a many-to-many relationship
-- between projects and tags.
-- -----------------------------------------------------------------------------

CREATE TABLE project_tags (
    project_id INT NOT NULL
        REFERENCES projects(id)
        ON DELETE CASCADE,

    tag_id INT NOT NULL
        REFERENCES tags(id)
        ON DELETE CASCADE,

    PRIMARY KEY (project_id, tag_id)
);


-- -----------------------------------------------------------------------------
-- Project Skills
-- Junction table connecting projects to the skills used to create them.
-- Skills are defined in 01_users_skills.sql.
-- -----------------------------------------------------------------------------

CREATE TABLE project_skills (
    project_id INT NOT NULL
        REFERENCES projects(id)
        ON DELETE CASCADE,

    skill_id INT NOT NULL
        REFERENCES skills(id)
        ON DELETE CASCADE,

    PRIMARY KEY (project_id, skill_id)
);


-- -----------------------------------------------------------------------------
-- Indexes
-- -----------------------------------------------------------------------------

CREATE INDEX idx_projects_user_id
    ON projects(user_id);

CREATE INDEX idx_project_media_project_id
    ON project_media(project_id);

CREATE INDEX idx_tags_name
    ON tags(name);

CREATE INDEX idx_project_tags_tag_id
    ON project_tags(tag_id);

CREATE INDEX idx_project_skills_skill_id
    ON project_skills(skill_id);
