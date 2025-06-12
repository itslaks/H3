students = [
    ("lakshan",[88,89,90]),
    ("haley",[89,88,90]),
    ("harish",[90,91,85])
]

print("Average Marks of Each Student: ")
topper_name = ""
highest_avg = 0

for name, marks in students:
    avg = sum(marks)/len(marks)
    print(f"{name} - Average: {avg:.2f}")

    if avg > highest_avg:
        highest_avg = avg
        topper_name = name

print("\nTopper:",topper_name)

students.append(("Rock", [80,89,95]))

for i in range(len(students)):
    if students[i][0] == "Jennifer":
        students[i][1][1] = 89
        break

print("\n Updated Student's List: ")
for name, marks in students:
    print(f"{name}: {marks}")

student_stats = []

for name, marks in students:
    total = sum(marks)
    avg = total/len(marks)
    student_stats.append((name, total, round(avg, 2)))

student_stats.sort(key=lambda x: x[2], reverse=True)

print("\n Students sorted by Average Marks: ")
for name, total, avg in student_stats:
    print(f"{name} - Total: {total}, Average: {avg}")
