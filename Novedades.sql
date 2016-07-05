SET LANGUAGE Spanish;
select 
distinct fld_idedoc,
cli_data10 as [Vertical],
ges_idclie as [N° Proyecto],
ecl_nomemp as [Cliente],
fld_idedoc as [N° Incidente],
datename(weekday,substring(ges_fehocr,1,8))+' '+substring(ges_fehocr,7,2) as [Día],
substring(ges_fehocr,9,2)+':'+substring(ges_fehocr,11,2) as [Hora],
par_desl02 as [Estado],
ges_data19 as [Horas],
fld_refdoc as [Referencia],
ltrim(rtrim(rec_nombre)) +' '+ ltrim(rtrim(rec_apepat)) as [Responsable],
(select flh_nomrec from FLT_HISTORIA where flh_numtar = 46 and flh_idedoc = convert(varchar(16),ges_numcon)+'-1') as [Resolutor]
from
gestion
        inner join flt_documentos on convert(varchar(15),ges_numcon)+'-1' = fld_idedoc
        inner join flt_historia on convert(varchar(15),ges_numcon)+'-1' = flh_idedoc
        inner join parametros on par_numpar = 10 and par_codp01 = fld_codest
        inner join CLIENTES ON cli_idclie = ges_idclie
        inner join proyecto_empresa_cli on ges_idclie = pec_ideclie //and pec_indprio = 'S'
        inner join EMPRESA_CLI on pec_numemp = ecl_numemp and pec_numemp not in  (9999,9998,9997,9996)
        left join RECURSO on ges_numrec = rec_numrec
        where substring(ges_fehocr,1,12) >= '201406131600' and substring(ges_fehocr,1,12) <= '201406152359'
order by cli_data10,fld_idedoc