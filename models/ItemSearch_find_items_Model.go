package models

//Controller method model
import (
		
	"github.com/dronm/gobizap/fields"
)

type ItemPriorityList []int
type ItemFeatureQuality string
type ItemFeatureOption struct {
	Id int `json:"id"`
	Val bool `json:"val"`
}
type ItemFeatureOptionList []ItemFeatureOption

type ItemSearch_find_items_val struct {
	Auto_make_id int `json:"auto_make_id"`
	Auto_model_id int `json:"auto_model_id"`
	Auto_model_generation_id int `json:"auto_model_generation_id"`
	Auto_model_year int `json:"auto_model_year"`
	Auto_body_id int `json:"auto_body_id"`
	Item_priorities ItemPriorityList `json:"item_priorities"`
	Item_feature_qualities ItemFeatureQuality `json:"item_feature_qualities"`
	Item_feature_options ItemFeatureOptionList `json:"item_feature_options"`
}

type ItemSearch_find_items struct {
	Criteria ItemSearch_find_items_val `json:"criteria"`
	From fields.ValInt `json:"from"`
	Count fields.ValInt `json:"count"`
}
type ItemSearch_find_items_argv struct {
	Argv *ItemSearch_find_items `json:"argv"`	
}

