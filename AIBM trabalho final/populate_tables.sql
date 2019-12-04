insert into dim_sexo(valor) select distinct(SEXO) from urg_inform_geral;
insert into dim_alta_des_especialidade(descricao) select distinct(ALTA_DES_ESPECIALIDADE) from urg_inform_geral;
insert into dim_des_local(descricao) select distinct(DES_LOCAL) from urg_inform_geral;
insert into dim_des_causa(descricao) select distinct(DES_CAUSA) from urg_inform_geral;
insert into dim_des_proveniencia(descricao) select distinct(DES_PROVENIENCIA) from urg_inform_geral;
insert into dim_data(valor) select date(DATAHORA_ADM) adm from urg_inform_geral union distinct 
	select date(DATAHORA_ALTA) alta from urg_inform_geral union distinct
		select DTA_NASCIMENTO nasc from urg_inform_geral;

insert into fact_urgencia(urg_episodio, adm_time, alta_time, data_adm, data_alta, local, proveniencia, causa, sexo, especialidade, data_nascimento)
select URG_EPISODIO, time(DATAHORA_ADM), time(DATAHORA_ALTA), 
	adm.id_data, alta.id_data, deslocal.id_des_local, prov.id_des_proveniencia, causa.id_des_causa, sexo.id_sexo, especial.id_alta_des_especialidade, nasc.id_data 
		from urg_inform_geral uig
        inner join dim_data adm on adm.valor = date(uig.DATAHORA_ADM)
        inner join dim_data alta on alta.valor = date(uig.DATAHORA_ALTA)
        inner join dim_des_local deslocal on deslocal.descricao = uig.DES_LOCAL
        inner join dim_des_proveniencia prov on prov.descricao = uig.DES_PROVENIENCIA
        inner join dim_des_causa causa on causa.descricao = uig.DES_CAUSA
		inner join dim_sexo sexo on sexo.valor = uig.SEXO
        inner join dim_alta_des_especialidade especial on especial.descricao = uig.ALTA_DES_ESPECIALIDADE
        inner join dim_data nasc on nasc.valor = uig.DTA_NASCIMENTO;

select * from fact_urgencia;