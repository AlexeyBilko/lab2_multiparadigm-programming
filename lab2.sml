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


fun number_in_month(datesList : (int * int * int) positiveNumbersList, month : int) =
    if null datesList
    then 0
    else 
        if #2 (hd datesList) = month
        then number_in_month((tl datesList), month) + 1
        else number_in_month((tl datesList), month)


 fun number_in_months(dateList : (int * int * int) positiveNumbersList, months : int positiveNumbersList) =
    if null dateList
    then 0
    else
        if null months
        then 0
        else number_in_month(dateList, hd months) + number_in_months(dateList, tl months);


fun dates_in_month(dateList : (int * int * int) positiveNumbersList, months : int) =
    if null dateList
    then []
    else 
        if #2 (hd dateList) = months
        then (hd dateList)::dates_in_month((tl dateList), months)
        else dates_in_month((tl dateList), months);



fun dates_in_months(dateList : (int * int * int) positiveNumbersList, months : int positiveNumbersList) =
    if null dateList
    then []
    else 
        if null months
        then []
        else
            if dates_in_month(dateList, hd months) <> []
            then dates_in_month(dateList, hd months) @ dates_in_months(dateList, tl months)
            else dates_in_months(dateList, tl months);


fun get_nth(positiveNumbersList : string positiveNumbersList, n : int) =
    if null positiveNumbersList
    then ""
    else
        if n = 1
        then hd positiveNumbersList
        else get_nth(tl positiveNumbersList, n-1);


fun date_to_string(date : (int * int * int)) =
    get_nth(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], #2 date) 
        ^ " "
        ^ Int.toString(#3 date)
        ^ ", "
        ^ Int.toString(#1 date)


fun number_before_reaching_sum(sum : int, positiveNumbersList : int list) =
    if null positiveNumbersList
    then 0
    else
        let
            fun check_next_item(n : int, count : int, positiveNumbersList : int list) =
                if (hd positiveNumbersList + count) >= sum
                then n
                else number_before_helper(n + 1, count + hd positiveNumbersList, tl positiveNumbersList)
        in
            check_next_item(0, 0, positiveNumbersList)
        end


fun what_month(day : int) = number_before_reaching_sum(day, [31, 28, 31, 30, 31, 30, 31,31, 30, 31, 30, 31]) + 1;


fun month_range(day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1 + 1, day2)


fun oldest_date(dateList : (int * int * int) list) =
    if null dateList
    then NONE
    else
        let
            fun if_oldest(date : (int * int * int), dateList : (int * int * int) list) =
                if null dateList
                then true
                else 
                    if is_older(date, hd dateList) (*function from task 1*)
                    then if_oldest(date, tl dateList)
                    else false

            fun find_oldest(dateList : (int * int * int) list) =
                if if_oldest(hd dateList, tl dateList)
                then hd dateList
                else find_oldest(tl dateList)
        in
            SOME (find_oldest(dateList))
        end


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
            else print("All tests passed!");

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
    then print("Test 1 failed!")
    else
        if dates_in_month([],10) <> []
        then print("Test 2 failed!")
        else
            if dates_in_month([(2021,9,10),(2020,10,10)], 8) <> []
            then print("Test 3 failed!")
            else print("All tests passed!");

dates_in_month_test();

fun dates_in_months_test() =
    if dates_in_months([(2020,10,10),(2020,8,22),(2020,11,27)], [10,11]) <> [(2020,10,10),(2020,11,27)]
    then print("Test 1 failed!")
    else     
        if dates_in_months([(2020,10,10)], []) <> []
        then print("Test 2 failed!")
        else 
            if dates_in_months([], [10]) <> []
            then print("Test 3 failed!")
            else print("All tests passed!");

dates_in_months_test();

fun get_nth_test() =
    if  get_nth(["word1", "word2", "word3", "word4"], 1) <> "word1"
    then print("Test 1 failed!")
    else
        if get_nth(["word1", "word2", "word3", "word4"], 4) <> "word4"
        then print("Test 2 failed!")
        else
            if get_nth([], 4) <> ""
            then print("Test 3 failed!")
            else print("All tests passed!");

get_nth_test();

fun date_to_string_test() =
    if  date_to_string(2020,10,10) <> "October 10, 2020"
    then print("Test 1 failed!")
    else print("All tests passed!");

date_to_string_test();

fun number_before_reaching_sum_test() =
    if  number_before_reaching_sum(61, [10, 20, 30, 40, 50]) <> 3
    then print("Test 1 failed!")
    else
        if number_before_reaching_sum(30, []) <> 0
        then print("Test 2 failed!")
        else print("All tests passed!");

number_before_reaching_sum_test();

fun what_month_test() =
    if  what_month(100) <> 4
    then print("Test 1 failed!")
    else
        if what_month(200) <> 7
        then print("Test 2 failed!")
        else print("All tests passed!");

what_month_test();

fun month_range_test() =
    if month_range(100,110) <> [4,4,4,4,4,4,4,4,4,4,4]
    then print("Test 1 failed!")
    else
        if month_range(300,310) <> [10,10,10,10,10,11,11,11,11,11,11]
        then print("Test 2 failed!")
        else 
            if month_range(300,290) <> []
            then print("Test 3 failed!")
            else print("All tests passed!");

month_range_test();


fun oldest_date_test() =
    if oldest_date([(2020,10,10), (2020,10,11), (2020,10,9), (2020,11,10)]) <> SOME (2020,10,9)
    then print("Test 1 failed!")
    else 
        if oldest_date([(2020,10,10)]) <> SOME (2020,10,10)
        then print("Test 2 failed!")
        else          
            if oldest_date([]) <> NONE
            then print("Test 3 failed!")
            else print("All tests passed!");

oldest_date_test();