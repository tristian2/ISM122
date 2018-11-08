print 'in the sproce, we were looking at validating the input, but we will move that responsibility to constraints on the tables '
--first validate entries
IF (ISNULL(@surname, '') = '')
BEGIN
    RAISERROR('Invalid parameter: @surname cannot be NULL or zero', 18, 0)
    RETURN
END
print 'after validate surname'
IF (ISNULL(@forename, '') = '')
BEGIN
    RAISERROR('Invalid parameter: @forename cannot be NULL or empty', 18, 0)
    RETURN
END
print 'after validate forename'
IF (ISNULL(@email, '') = '')
BEGIN
    RAISERROR('Invalid parameter: @email cannot be NULL or empty', 18, 0)
    RETURN
END
print 'after validate email empty'
IF (ISNULL(@qualifications, '') = '')
BEGIN
    RAISERROR('Invalid parameter: @qualifications cannot be NULL or empty', 18, 0)
    RETURN
END