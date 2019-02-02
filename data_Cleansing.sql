SET SERVEROUTPUT ON SIZE 100000
DECLARE
  v_count INTEGER	:= 0;
BEGIN
	FOR	v_tables
	IN (
		SELECT table_name 
			FROM all_tables
			WHERE OWNER  = '<db user name>'
	)
	LOOP
		FOR v_columns 
		IN (
			SELECT table_name, column_name
			FROM all_tab_columns
			WHERE table_name = v_tables.table_name
			AND DATA_TYPE = 'VARCHAR2'
		)
		LOOP
			IF v_columns.column_name IS NOT NULL
			THEN
				EXECUTE IMMEDIATE
					'SELECT count(*) 
					FROM ' || v_columns.table_name ||' 
					WHERE REGEXP_LIKE('|| v_columns.column_name ||',''([-,&=?{}\();~|$!>*%-@#`^_+:"''''<./[]|])+?'')' 
				INTO v_count;
				
				IF v_count > 0
				THEN
					dbms_output.put_line('Found in ' || v_columns.table_name ||'.' || v_columns.column_name ||': (' || v_count || ') time(s)');
				END IF;
			END IF;
		END LOOP;
	END LOOP;
END;
/