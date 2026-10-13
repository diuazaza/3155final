-- Insert Sample Skills
INSERT INTO skills (name, category) VALUES
('Python', 'Coding'),
('Game Development', 'Coding'),
('Blender', '3D Modeling'),
('Digital Illustration', 'Art'),
('Music Composition', 'Audio');

-- Insert Persona Users
INSERT INTO users (username, email, password_hash, bio) VALUES
('maya_creates', 'maya@example.com', 'hashed_pass_1', 'Hobbyist maker building games and digital art.'),
('alex_learner', 'alex@example.com', 'hashed_pass_2', 'Beginner looking to learn 3D modeling and Blender.'),
('priya_explorer', 'priya@example.com', 'hashed_pass_3', 'Enjoys exploring new creative skills and hobbies.');

-- Map User Skills & Learn-From-Me Status
-- Maya knows Python (Advanced, willing to teach) and Digital Illustration (Intermediate, willing to teach)
INSERT INTO user_skills (user_id, skill_id, proficiency_level, is_open_to_teach) VALUES
(1, 1, 'Advanced', TRUE),
(1, 4, 'Intermediate', TRUE);

-- Alex knows Python at a Beginner level (not teaching)
INSERT INTO user_skills (user_id, skill_id, proficiency_level, is_open_to_teach) VALUES
(2, 1, 'Beginner', FALSE);