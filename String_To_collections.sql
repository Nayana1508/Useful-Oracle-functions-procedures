/*
Function to convert an input comma separated string to rows
*/

CREATE OR REPLACE FUNCTION String_To_collections(p_list varchar2 )
    RETURN sys.odcinumberlist
AS
    l_result_list    SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
    v_list           varchar2(32767) default p_list || ',';
    v_count_of_comma    PLS_INTEGER :=0;
BEGIN
    loop
      exit when v_list is null;
      v_count_of_comma := instr(v_list, ',');
      l_result_list.extend;
      l_result_list(l_result_list.count) := ltrim(rtrim(substr(v_list,1,v_count_of_comma - 1)));
      
      v_list := substr(v_list, v_count_of_comma + 1);
    end loop;

    RETURN l_result_list;
END;

/*
sample call:
SELECT * 
  FROM 
TABLE(select String_To_collections('A,B,C') from dual);

--Output
A
B
C
*/
