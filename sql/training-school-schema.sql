BEGIN;
CREATE TABLE client (client_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY, first_name text NOT NULL, last_name text NOT NULL, email text UNIQUE, city text, state char(2), joined_on date NOT NULL DEFAULT CURRENT_DATE);
CREATE TABLE trainer (trainer_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY, first_name text NOT NULL, last_name text NOT NULL, email text NOT NULL UNIQUE);
CREATE TABLE course (course_code text PRIMARY KEY, course_name text NOT NULL, duration_hours integer NOT NULL CHECK(duration_hours>0), fee numeric(10,2) NOT NULL CHECK(fee>=0));
CREATE TABLE class_offering (class_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY, course_code text NOT NULL REFERENCES course(course_code), trainer_id bigint NOT NULL REFERENCES trainer(trainer_id), starts_at timestamptz NOT NULL, room text NOT NULL);
CREATE TABLE trainer_qualification (trainer_id bigint REFERENCES trainer(trainer_id) ON DELETE CASCADE, course_code text REFERENCES course(course_code) ON DELETE CASCADE, qualified_on date NOT NULL, PRIMARY KEY(trainer_id,course_code));
CREATE TABLE enrollment (class_id bigint REFERENCES class_offering(class_id) ON DELETE CASCADE, client_id bigint REFERENCES client(client_id) ON DELETE CASCADE, enrolled_at timestamptz NOT NULL DEFAULT now(), fee_paid numeric(10,2) CHECK(fee_paid>=0), PRIMARY KEY(class_id,client_id));
COMMIT;
