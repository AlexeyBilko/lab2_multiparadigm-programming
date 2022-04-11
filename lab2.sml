(*FUNCTIONS*)
fun is_older(firstDate : (int * int * int), secondDate : (int * int * int)) =
    if #1 firstDate < #1 secondDate
    then true
    else 
        if #1 firstDate = #1 secondDate andalso #2 firstDate < #2 secondDate
        then true
        else
            if #1 firstDate = #1 secondDate andalso #2 firstDate = #2 secondDate andalso #3 firstDate < #3 secondDate
            then true
            else false


fun number_in_month(datesList : (int * int * int) list, month : int) =
    if null datesList
    then 0
    else 
        if #2 (hd datesList) = month
        then number_in_month((tl datesList), month) + 1
        else number_in_month((tl datesList), month)


 fun number_in_months(dateList : (int * int * int) list, months : int list) =
    if null dateList
    then 0
    else
        if null months
        then 0
        else number_in_month(dateList, hd months) + number_in_months(dateList, tl months);



(*TESTS*)
fun is_older_test() =
    if is_older((2021, 10, 10), (2021, 10, 12)) <> true
    then print("Test 1 failed!")
    else
        if is_older((20021, 10, 10), (2021, 10, 10)) <> false
        then print("Test 2 failed!")
        else
            if is_older((20021, 10, 10), (2021, 10, 9)) <> false
            then print("Test 3 failed!")
            else print("All tests passed!");

is_older_test()

fun number_in_month_test() =
  if  number_in_month([(2021,10,10),(2020,10,11),(2020,11,10)], 10) <> 2
  then print("Test 1 failed!")
  else
    if number_in_month([(2021,10,10),(2021,10,11)], 9) <> 0
    then print("Test 2 failed!")
    else
        if number_in_month([], 34) <> 0
        then print("Test 2 failed")
        else
        print("Test of task2 passed!");

number_in_month_test()

fun number_in_months_test() =
    if number_in_months([(2021,9,10),(2020,10,10),(2020,10,11),(2020,11,20),(2020,11,21)],[10,11]) <> 4
    then print("Test 1 failed!")
    else
        if number_in_months([],[10,11]) <> 0
        then print("Test 2 failed!")
        else
            if number_in_months([(2021,10,10),(2020,10,11)],[]) <> 0
            then print("Test 3 failed!")
            else print("All tests passed!");

number_in_months_test();
