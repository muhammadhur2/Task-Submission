# Assignment

This is the Readme file for the assignment.

## Considerations

- All the files provided are tested using Ubuntu 22.04
- All sub-folders have their own seperate Readme files

## Task 1

Task 1 has all the files needed to create Infrastructure.

### Terraform
- Terraform folder has all the files needed to start the infrastructure.
- This code also has the setup needed to start the ec2 instance with nginx already running and having it's root page as Hello World
- I have not tested these configurations because I did not have access to an AWS account.

### Other folders
- All the other folders in this section are methods that can be used to deploy nginx page with Hello World in an already setup instance

## Task 2

### Consideration
- I have tested the code using my own mysql server and subsequent connections have been added to the .env files
 
### Code
- This folder has the code file written in Nodejs with test files.

### Automation
- This folder has 2 different methods to deploy the code on the server:
1. Ansible
2. Through deployment shell script

- Both shell script and ansible script also installs docker files in the server and they are all that are needed