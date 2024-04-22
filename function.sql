CREATE TABLE product (					
	pid integer not null primary key,				
	name varchar(30) not null,					
	pqty  integer not null);

CREATE TABLE sale (
   sid integer not null primary key,
   sdate date not null,
   address varchar(30));
   
CREATE TABLE sale_item (
	sid integer not null,
	pid integer not null,
	sqty integer not null,
	CONSTRAINT pk_sale_item PRIMARY KEY (sid,pid),
	CONSTRAINT fk_sale_item_sale FOREIGN KEY (sid) REFERENCES sale(sid),
	CONSTRAINT fk_sale_item_product FOREIGN KEY (pid) REFERENCES product(pid)
);


create or replace procedure ins_sale_item (qttup int) language plpgsql
as $$
declare
    itBySale int[6]:='{2,4,7,8,9,10}';
    nprod int;
    counter_nprod int := 0;
    sale_item_tup sale_item%rowtype;
    array_prod int[];
    array_sale int[];
    qt_prod int;
    qt_sale int;
    counter int:=0;
begin

    select array_agg(pid) into array_prod from product;
    select count(pid) into qt_prod from product;

    select array_agg(sid) into array_sale from sale;
    select count(sid) into qt_sale from sale;



    -- executa qttup vezes
    loop
        -- seleciona um sid
        nprod := itBySale[(random()*5)::int+1];  
        sale_item_tup.sid := array_sale[(random()*(qt_sale-1))::int+1];

            --executa nprod vezes (vindo de itBySale)
            loop
                -- seleciona um pid e um sqty
                sale_item_tup.pid := array_prod[(random()*(qt_prod-1))::int+1];
                sale_item_tup.sqty := (random()*1000)::int;
                
                raise notice 'sale item: %', sale_item_tup;
                -- insere em sale item
                
                if (not exists (select 1 from sale_item where sid=sale_item_tup.sid and pid=sale_item_tup.pid))
                    then
                    insert into sale_item (sid, pid, sqty) values (sale_item_tup.sid, sale_item_tup.pid, sale_item_tup.sqty);
                    counter_nprod := counter_nprod + 1;
                end if;

                exit when counter_nprod > nprod;
            end loop;

            counter := counter +1;

        exit when counter >= qttup;
        
    end loop;

end; $$;

create or replace procedure ins_product(qttup int ) Language plpgsql
as $$
declare
   prd_tup product%rowtype;
   counter int:=0;
   stock int[5]:='{3,5,8,10,15}';
begin
   raise notice 'Range ids: %',100*qttup;
   -- Or stock:=Array[3,5,8,10,15];
   loop
      prd_tup.pid:=(random()*100*qttup)::int;
      prd_tup.name:=left(MD5(random()::text),20);
      prd_tup.pqty:=stock[(random()*4)::int+1];
      raise notice 'product: %',prd_tup;
      if (not exists (select 1 from product where pid=prd_tup.pid))
      then
        insert into product (pid,name,pqty) values (prd_tup.pid,prd_tup.name,prd_tup.pqty);
        counter:=counter+1;
      end if;
      exit when counter >= qttup;
   end loop;
end; $$;

--
create or replace procedure ins_sale(qttup int ) Language plpgsql
as $$
declare
   sale_tup sale%rowtype;
   counter int:=0;
begin
   raise notice 'Range ids: %',100*qttup;
   loop
      sale_tup.sid:=(random()*100*qttup)::int;
      sale_tup.sdate:='2023-01-01 00:00:00'::timestamp + random()*(now()-timestamp '2023-01-01 00:00:00');
      sale_tup.address:=left(MD5(random()::text),30);
      raise notice 'Sale: %',sale_tup;
      if (not exists (select 1 from sale where sid=sale_tup.sid))
      then
        insert into sale (sid,sdate, address) values (sale_tup.sid,sale_tup.sdate, sale_tup.address);
        counter:=counter+1;
      end if;
      exit when counter >= qttup;
   end loop;
end; $$;

create or replace procedure call_all (qtsale int, qtprod int, qtitem int) language plpgsql
as $$
begin
   call ins_product(qtprod);
   call ins_sale(qtsale);
   call ins_sale_item(qtitem);
end; $$;
