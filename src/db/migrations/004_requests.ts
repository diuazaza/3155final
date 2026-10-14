import type { Kysely } from 'kysely';
import { runSql } from '../run-sql.js';

const statements = `
CREATE TABLE learning_requests (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    learner_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    creator_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
    message TEXT,
    status VARCHAR(20) DEFAULT 'pending' NOT NULL
        CHECK (status IN ('pending', 'accepted', 'declined')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CHECK (learner_id <> creator_id)
);

CREATE TABLE collaboration_requests (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sender_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    receiver_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id INT REFERENCES projects(id) ON DELETE CASCADE,
    skill_id INT REFERENCES skills(id) ON DELETE SET NULL,
    message TEXT,
    status VARCHAR(20) DEFAULT 'pending' NOT NULL
        CHECK (status IN ('pending', 'accepted', 'declined')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CHECK (sender_id <> receiver_id),
    CHECK (project_id IS NOT NULL OR skill_id IS NOT NULL)
);

CREATE INDEX idx_learning_requests_learner_id
    ON learning_requests(learner_id);

CREATE INDEX idx_learning_requests_creator_id
    ON learning_requests(creator_id);

CREATE INDEX idx_learning_requests_skill_id
    ON learning_requests(skill_id);

CREATE INDEX idx_collaboration_requests_sender_id
    ON collaboration_requests(sender_id);

CREATE INDEX idx_collaboration_requests_receiver_id
    ON collaboration_requests(receiver_id);

CREATE INDEX idx_collaboration_requests_project_id
    ON collaboration_requests(project_id);
`;

export async function up(db: Kysely<any>): Promise<void> {
  await runSql(db, statements);
}

export async function down(db: Kysely<any>): Promise<void> {
  await runSql(
    db,
    `
    DROP TABLE collaboration_requests;
    DROP TABLE learning_requests;
    `,
  );
}