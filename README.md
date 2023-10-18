# TEAM FORMATION
To implement these functionalities in a Flutter application using the provided mock data, you'll need to create a Flutter project and follow these steps:

## 1. Data Processing:

- Download the mock data and include it in your Flutter project. You can use the `assets` directory to store the data.
- Parse the data using a library like `json_serializable` and create Dart objects to represent the users.

## 2. Create the Flutter UI:

- Build the user interface with Flutter, displaying users in a card format with pagination (10 users per page).
- Add a search box at the top for filtering users by name.
- Build the UI by using Flutter widgets like `ListView` and `TextField`.


![WhatsApp Image 2023-10-18 at 22 40 15](https://github.com/Shital1471/team_formation/assets/114605853/80f08c16-d74c-4ca8-ab51-1275f5b53c1a)
![WhatsApp Image 2023-10-18 at 22 40 14](https://github.com/Shital1471/team_formation/assets/114605853/47061a1e-c811-4570-97ad-fff2c3e15ac4)


## 3. Filtering Logic: 
- Create dropdown menus or custom widgets for filtering users by Domain, Gender, and Availability.
- Implement the filtering logic in Dart to filter users based on the selected filters and the search input.
- Ensure that multiple filters from the same category can be used simultaneously.


![WhatsApp Image 2023-10-18 at 22 40 17](https://github.com/Shital1471/team_formation/assets/114605853/92fabbab-3d3f-4b6f-b544-4786a2a6eadd)



## 4. Create a Team: 

- Implement a button to create a team by selecting users from unique domains (only available users).
- When the "Add To Team" button is pressed, add the users from unique domains to the team.

![WhatsApp Image 2023-10-18 at 22 40 17 (1)](https://github.com/Shital1471/team_formation/assets/114605853/b3870f56-282a-4430-9518-c3df11527869)



## 5. Team Details Screen:

- Create a separate screen  to display the details of the created team.
- Show the members of the team and their respective domains.

![WhatsApp Image 2023-10-18 at 22 40 17 (2)](https://github.com/Shital1471/team_formation/assets/114605853/aeab52fa-aef9-4c67-b238-3ed251e5ca08)
![WhatsApp Image 2023-10-18 at 22 40 18](https://github.com/Shital1471/team_formation/assets/114605853/ca115682-c7c5-4874-8f51-ca4b7d3c1c75)


