package models

import(
	"github.com/dronm/gobizap/fields"	
)

type Doc_id struct {
	Id fields.ValInt `json:"id" required:"true"`
}
type Doc_id_argv struct {
	Argv *Doc_id `json:"argv"`	
}

//
type Mgateway_callback map[string]string

type Mgateway_callback_argv struct {
	Argv *Mgateway_callback `json:"argv"`	
}

//Структура Одежда
type EmployeeCloth struct {
	Height fields.ValInt `json:"height"`
	Size fields.ValText `json:"size"`
	Shoes fields.ValText `json:"shoes"`
}
type EmployeeCloth_argv struct {
	Argv *EmployeeCloth `json:"argv"`	
}

//Структура Стаж
type EmployeeExpirience struct {
	Date fields.ValDate `json:"date"`
	Years fields.ValInt `json:"years"`
}
type EmployeeExpirience_argv struct {
	Argv *EmployeeExpirience `json:"argv"`	
}

//Структура Дети
type EmployeeChildren struct {
	Birthdate fields.ValDate `json:"birthdate"`
	Sex fields.ValText `json:"sex"`
}
type EmployeeChildren_argv struct {
	Argv *EmployeeChildren `json:"argv"`	
}


