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


fun dates_in_month(dateList : (int * int * int) list, months : int) =
    if null dateList
    then []
    else 
        if #2 (hd dateList) = months
        then (hd dateList)::dates_in_month((tl dateList), months)
        else dates_in_month((tl dateList), months);



fun dates_in_months(dateList : (int * int * int) list, months : int list) =
    if  null dateList
    then []
    else 
        if null months
            then []
            else
                if dates_in_month(dateList, hd months) <> []
                then dates_in_month(dateList, hd months) @ dates_in_months(dateList, tl months)
                else dates_in_months(dateList, tl months);


fun get_nth(list : string list, n : int) =
    if null list
    then ""
    else
        if n = 1
        then hd list
        else get_nth(tl list, n-1)


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
            else print("Test of task2 passed!");

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

fun dates_in_month_test() =
    if dates_in_month([(2021,9,10),(2020,10,10),(2020,10,11),(2020,11,20),(2020,11,21)], 11) <> [(2020,11,20),(2020,11,21)]
    then raise Fail "Test 1 failed!"
    else
        if dates_in_month([],10) <> []
        then raise Fail "Test 2 failed!"
        else
            if dates_in_month([(2021,9,10),(2020,10,10)], 8) <> []
            then raise Fail "Test 3 failed!"
            else print("All tests passed!");

dates_in_month_test();

fun dates_in_months_test() =
    if dates_in_months([(2020,10,10),(2020,8,22),(2020,11,27)], [10,11]) <> [(2020,10,10),(2020,11,27)]
    then print("Test 1 failed!")
    else     
        if dates_in_months([(2020,10,10)], []) <> []
        then print("Test 1 failed!")
        else 
            if dates_in_months([], [10]) <> []
            then print("Test 1 failed!")
            else print("All tests passed!");

dates_in_months_test();

fun get_nth_test() =
    if  get_nth(["word1", "word2", "word3", "word4"], 1) <> "word1"
    then raise Fail "Test 1 failed!"
    else
        if get_nth(["word1", "word2", "word3", "word4"], 4) <> "word4"
        then raise Fail"Test 2 failed!"
        else
            if get_nth([], 4) <> ""
            then raise Fail"Test 2 failed!"
            else print("All tests passed!");

get_nth_test();