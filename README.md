erDiagram
    users ||--o{ projects : "creates / posts"
    users ||--o{ learning_requests : "sends (as sender)"
    users ||--o{ learning_requests : "receives (as receiver)"
    users ||--o{ collaboration_requests : "sends (as sender)"
    users ||--o{ collaboration_requests : "receives (as receiver)"
    users ||--o{ saved_projects : "saves"
    users ||--o{ project_likes : "likes"
    users ||--o{ project_comments : "writes"
    users ||--o{ user_skills : "possesses"

    projects ||--o{ saved_projects : "is saved by"
    projects ||--o{ project_likes : "is liked by"
    projects ||--o{ project_comments : "has"
    projects ||--o{ project_media : "contains"
    projects ||--o{ project_tags : "tagged with"
    projects ||--o{ project_skills : "uses"
    projects ||--o{ collaboration_requests : "referenced in"

    tags ||--o{ project_tags : "categorizes"
    skills ||--o{ user_skills : "categorizes user"
    skills ||--o{ project_skills : "used in project"
    skills ||--o{ learning_requests : "subject of"

    users {
        int id PK
        string username
        string email
        string password_hash
        string bio
        datetime created_at
    }

    skills {
        int id PK
        string name
        string category
    }

    user_skills {
        int user_id PK, FK
        int skill_id PK, FK
        string proficiency_level
        boolean is_open_to_teach
    }

    projects {
        int id PK
        int user_id FK
        string title
        string description
        string project_url
        boolean is_seeking_collaborators
        datetime created_at
    }

    project_media {
        int id PK
        int project_id FK
        string media_type
        string media_url
        int display_order
    }

    tags {
        int id PK
        string name
    }

    project_tags {
        int project_id PK, FK
        int tag_id PK, FK
    }

    project_skills {
        int project_id PK, FK
        int skill_id PK, FK
    }

    saved_projects {
        int user_id PK, FK
        int project_id PK, FK
        datetime created_at
    }

    project_likes {
        int user_id PK, FK
        int project_id PK, FK
        datetime created_at
    }

    project_comments {
        int id PK
        int project_id FK
        int user_id FK
        int parent_comment_id FK
        string content
        datetime created_at
    }

    learning_requests {
        int id PK
        int sender_id FK
        int receiver_id FK
        int skill_id FK
        string message
        string status
        datetime created_at
    }

    collaboration_requests {
        int id PK
        int sender_id FK
        int receiver_id FK
        int project_id FK
        string message
        string status
        datetime created_at
    }
