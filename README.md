# DataCleansingScript

This PL/SQL Script Allows you to search in entire DB tables of particular DbUser for any illeagle character, and report back those dirty columns.

Useful in during Data Cleansing phase to find any data irregulatories.

As of Script, it uses Lazy Regex match for characters to search for, and so is faster then just any random non-lazy regex.
