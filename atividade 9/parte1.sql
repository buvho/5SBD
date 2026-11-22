CREATE SEQUENCE seq_ticket_diario
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 5
    CYCLE
    CACHE 2;

SELECT seq_ticket_diario.NEXTVAL AS numero_ticket
FROM DUAL
CONNECT BY LEVEL <= 7;