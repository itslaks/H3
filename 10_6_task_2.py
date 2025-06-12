import numpy as np

temps = np.array([
    [28, 30, 29, 31, 32, 33, 34],  
    [35, 34, 36, 37, 38, 36, 35],  
    [22, 23, 24, 25, 26, 27, 28],  
    [31, 30, 29, 28, 27, 26, 25],  
    [39, 38, 40, 41, 42, 40, 39]
])

days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

# 1. Function: Average temperature of a city for the week
def average_temperature(city_index):
    return np.mean(temps[city_index])

# 2. Function: Hottest day index for a city
def hottest_day(city_index):
    return np.argmax(temps[city_index])

# 3. Loop through all cities and print average temperature and hottest day
print("City-wise Average Temperature and Hottest Day:")
for i in range(5):
    avg_temp = average_temperature(i)
    hot_day_index = hottest_day(i)
    hot_day_name = days[hot_day_index]
    print(f"City {i+1}: Avg Temp = {avg_temp:.2f}°C, Hottest Day = {hot_day_name} (Index: {hot_day_index})")
print()

# 4. Function: Day-wise average temperature across all cities
def day_wise_avg():
    return np.mean(temps, axis=0)

# Print day-wise average
day_avg = day_wise_avg()
print("Day-wise Average Temperatures Across All Cities:")
for i in range(7):
    print(f"{days[i]}: {day_avg[i]:.2f}°C")
print()

# 5. Loop to find:
# City with highest weekly average
city_avgs = [average_temperature(i) for i in range(5)]
highest_city_index = np.argmax(city_avgs)

# Day with lowest average temperature
lowest_day_index = np.argmin(day_avg)

print(f"City with highest average temperature: City {highest_city_index + 1} ({city_avgs[highest_city_index]:.2f}°C)")
print(f"Day with lowest average temperature: {days[lowest_day_index]} ({day_avg[lowest_day_index]:.2f}°C)")
