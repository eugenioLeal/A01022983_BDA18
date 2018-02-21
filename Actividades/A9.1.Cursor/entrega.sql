

DELIMITER
CREATE PROCEDURE micursor()
begin
  declare done INT DEFAULT FALSE;
  declare genre varCHAR(20);
  declare tid,cid mynumber;
  declare cur1 CURSOR FOR select film_id from film;
  declare cur2 CURSOR FOR select category_id from film_category where category_id=tid;

  declare CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;
  read_loop: LOOP

    IF done THEN
      LEAVE read_loop;
    end IF;
        FETCH cur1 INTO tid;
        FETCH cur2 INTO cid;
        update film SET title = concat((select name from category where category_id=cid),"_",(select tile from films WHERE id = tid));

    end LOOP;

  CLOSE cur1;

end;
