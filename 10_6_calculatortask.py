def simple_calculator():
    print("Simple Calculator (Runs 4 Times) ")

    for i in range(2):
        print(f"\nCalculation {i + 1}:")

        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))

        print("Choose operation: +  -  *  /")
        op = input("Enter operator: ")

        if op == '+':
            result = num1 + num2
        elif op == '-':
            result = num1 - num2
        elif op == '*':
            result = num1 * num2
        elif op == '/':
            if num2 == 0:
                print("❌ Error: Cannot divide by zero!")
                continue
            result = num1 / num2
        else:
            print("❌ Invalid operator! Use + - * /")
            continue

        print(f"Result: {num1} {op} {num2} = {result}")

simple_calculator()
