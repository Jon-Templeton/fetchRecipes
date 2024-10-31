### Steps to Run the App
Clone the repo and run using the Xcode Simulator.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized keeping a clean and organized codebase. The views are broken down into manageable components. The backend api logic is also broken out into seperate files. I focused on this because setting up an organized codebase is important when scaling.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
This project took me 2.5 hours to complete. Majority of the time was spent building the UI. Setting up the project structure and API call was pretty quick. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
No significant trade-offs where necessary.

### Weakest Part of the Project: What do you think is the weakest part of your project?
This project does not contain unit tests. For the sake of speed, I did not include unit tests. Instead, I rotated which API endpoint is called on each refresh of the data. For testing purposes, each refresh of the screen rotates between the valid, malformed, and empty endpoints. This is done to show how the UI handles the different scenarios.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
I included an external library for caching the images. This library creates an API similar to AsyncImage() and handles the caching automatically. The library can be found here: https://github.com/baskurthalit/asyncImage.git

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
<iframe width="1206" height="2622" src="https://www.youtube.com/shorts/W1q7Chv8SeQ" frameborder="0" allowfullscreen></iframe>
