CREATE OR REPLACE FUNCTION update_comment_type() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.postid IS NOT NULL AND OLD.postid IS NULL THEN
        NEW.podcastid = NULL;
        NEW.posttype = 'DISCUSSION';
    END IF;

    IF NEW.podcastid IS NOT NULL AND OLD.podcastid IS NULL THEN
        NEW.postid = NULL;
        NEW.posttype = 'PODCAST';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_update_comment_type
BEFORE UPDATE ON comments
FOR EACH ROW
EXECUTE FUNCTION update_comment_type();

UPDATE COMMENTS SET postid = 2 WHERE id = 44;