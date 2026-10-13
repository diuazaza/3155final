-- =============================================================================
-- COMMUNITY ENGAGEMENT MODULE
-- =============================================================================

CREATE TABLE saved_projects (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, project_id)
);

CREATE TABLE project_likes (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, project_id)
);

CREATE TABLE project_comments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,

    parent_comment_id INT
        REFERENCES project_comments(id)
        ON DELETE CASCADE,

    content TEXT NOT NULL,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_saved_projects_project_id
    ON saved_projects(project_id);

CREATE INDEX idx_project_likes_project_id
    ON project_likes(project_id);

CREATE INDEX idx_project_comments_project_id
    ON project_comments(project_id);

CREATE INDEX idx_project_comments_user_id
    ON project_comments(user_id);

CREATE INDEX idx_project_comments_parent_id
    ON project_comments(parent_comment_id);
