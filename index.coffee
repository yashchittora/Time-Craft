# HandCrafted by Yash Chittora
# My website: https://yashchittora.github.io/Personal-Portfolio/HTML/
# GitHub: https://github.com/yashchittora/
# on GitHub: https://github.com/yashchittora/ClockWidget

# ~~~ Settings ~~~
showAmPm = true; # true / false
showUserName = true; # true / false
showDate = true; # true / false
showDay = true; # true / false
centreWidget = true;  # true / false (true=centre , false=top)

# ----- Code For Widget -----
command: "whoami" #Fetches Username
# Clock refreshes every 10 seconds (10000 milliSeconds)
refreshFrequency: 10000

#CSS
style: """
  @import url('https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c:wght@800&display=swap');

  .container
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    font-family: "M PLUS Rounded 1c", sans-serif;
    color: rgba(255, 255, 255, 0.7);
    height:100vh;
    width:100vw;
    
  .time
    font-size: 5em;
    text-align: center;
    color: rgba(255, 255, 255, 0.7);
    justify-content: center;
    align-items: center;
    position: relative;
    bottom: 34%;
    font-family: "M PLUS Rounded 1c", sans-serif;

  .amPm
    font-size:0.3em;
    position:relative;
    left:2%;

  .text
    font-size: 2em;
    text-align: center;
    color: rgba(255, 255, 255, 0.7);
    justify-content: center;
    align-items: center;
    position: relative;
    bottom: 35%;
    font-family: "M PLUS Rounded 1c" , sans-serif;

  .text2
    font-size: 2em;
    text-align: center;
    color: rgba(255, 255, 255, 0.7);
    justify-content: center;
    align-items: center;
    position: relative;
    bottom: 35%;
    font-family: "M PLUS Rounded 1c", sans-serif; 
"""

render: -> """
  <div class="container">
      <div class="time">
        <span class="hour"></span>:<span class="min">:</span><span class="amPm"></span>
      </div>
    <div class="text">
      <span class="salutation"></span>
      <span class="name"></span>
    </div>
    <div class="text2">
      <span class="day"></span>
      <span class="date"></span>
    </div>
  </div>
"""

# Update function
update: (output, domEl) ->

  name = output.split(' ')
  name = name[0].charAt(0).toUpperCase() + name[0].slice(1)
  # Creating a new Date object for handling the data
  today = new Date()
  hour = today.getHours()
  minutes = today.getMinutes()
  dayNum = today.getDay()

  if (dayNum == 0)
    day = "Sunday";
  else if (dayNum == 1)
    day = "Monday";
  else if (dayNum == 2)
    day = "Tuesday";
  else if (dayNum == 3)
    day = "Wednesday";
  else if (dayNum == 4)
    day = "Thursday";
  else if (dayNum == 5)
    day = "Friday";
  else if (dayNum == 6)
    day = "Saturday";
  else
    day = "Unknown";

  formattedDate = today.toLocaleString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })

  # Add zero as a prefix if minutes have single digit
  minutes = "0"+ minutes if minutes < 10

  if 4 < hour <= 11
    timeSegment = "morning"
  else if 11 < hour <= 16
    timeSegment = "afternoon"
  else if 16 < hour <= 20
    timeSegment = "evening"
  else
    timeSegment = "night"
  
  if hour < 12
    amPm = "AM"
  else
    amPm = "PM"

  # 0=12 Hour fix
  hour = 12 if hour == 0;

  # 24 Hour to 12 Hour conversion
  hour = hour % 12 if hour > 12

  # Changing Contents of the Widget
  $(domEl).find('.salutation').text("Good #{timeSegment}")
  $(domEl).find('.name').text(" , #{name}") if showUserName
  $(domEl).find('.hour').text("#{hour}")
  $(domEl).find('.min').text("#{minutes}")
  $(domEl).find('.amPm').text("#{amPm}") if showAmPm
  $(domEl).find('.day').text("It's #{day}") if showDay
  $(domEl).find('.date').text("#{formattedDate}") if showDate

  if centreWidget
    # Apply CSS changes for condition1
    $(domEl).find('.time').css({
      'bottom': '3%',
    })
    $(domEl).find('.text').css({
      'bottom': '3%',
    })
    $(domEl).find('.text2').css({
      'bottom': '3%',
    })
