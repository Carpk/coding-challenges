let's build a course database for a University!

There will be lots of missing data at first, but we'll fill it in.

    Students can attend many classes
    Classes can have many students
    For each class a student attends, they have a final grade (think carefully about what table this data lives in)
    Each class has a teacher
    A teacher can teach only one class

Objectives
Basic schema

Design a basic "course database" using the requirements described in the challenge description.
Updated requirements

New requirements! These replace the ones above.

    Classes have many sections
    Sections have a start time and an end time
    Sections can either be Monday/Wednesday/Friday or Tuesday/Thursday
    Students can attend many classes and must be assigned to a specific section, but they can only attend one section per class
    Students are given a grade per section
    Teachers can teach multiple sections, but a section is taught by only one teacher
    Classes belong to a single department, but a department has multiple classes

Design an advanced "course database" using the requirements above.