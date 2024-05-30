package models

//Custom

//Controller method model
import (
	"encoding/json"	
	//"github.com/dronm/gobizap/fields"
)

//
func GetFeatureListVals() map[string][]string{
	features := make(map[string][]string)
	features["body_door"] = []string{ "опускное пп", "опускное зп", "форточка пп", "форточка пн", "форточка зн", "кузовное пн", "кузовное зн", "кузовное зп", "кузовное зд" }
	features["camera"] = []string{ "кам1", "кам2", "кам3", "кам4", "кам5", "кам>", "кам0", "кам8", "кам<" }
	features["filter_film"] = []string{ "green", "gray", "blue", "bronze" }
	features["heating"] = []string{ "ПО", "ОП" }
	features["glass_color"] = []string{ "green", "gray", "bronze", "blue", "violet" }
	features["heated_wipers"] = []string{ "ОЩ", "ОК", "ОЩ+ОК" }
	features["moulding"] = []string{ "П", "В", "Н", "О", "В+Н", "П+Н", "Л+П", "Л+Н+П", "?" }
	features["installation"] = []string{ "в клей", "откр.", "цельн." }
	features["item_position"] = []string{ "перед.", "задн." }
	features["sensors"] = []string{ "ДД", "ДД+ДС", "ДЗ", "ДД+ДЗ" }
	features["rain_sensor"] = []string{ "горизонт", "unknown", "периметр", "квадрат", "ромб", "м.круг", "капля", "б.круг" }
	features["side"] = []string{ "левое", "справа" }
	features["triplex"] = []string{ "сталинит", "триплекс" }
	features["vin_window"] = []string{ "vin", "vin I", "vin -", "vin2" }
	features["wheel_pos"] = []string{ "LHD", "RHD" }
	return features
}

//import_items.options
type SupplierItem_import_item_feature struct {
	Id string `json:"id"` //API, lat name
	Val json.RawMessage `json:"val"` //raw value	[]byte
	Db_id int
	Db_descr string
	Db_data_type string
	/*
	Accessories fields.ValBool `json:"accessories"`
	Acoustic fields.ValBool `json:"acoustic"`
	Analogue fields.ValText `json:"analogue"`
	Antenna fields.ValBool `json:"antenna"`
	Article fields.ValText `json:"article"`
	Aterm fields.ValBool `json:"aterm"`
	Body_door SupplierItem_import_item_feature_body_door `json:"body_door"`
	Camera SupplierItem_import_item_feature_camera `json:"camera"`
	Capsule fields.ValBool `json:"capsule"`
	Comment fields.ValText `json:"comment"`
	Determ fields.ValBool `json:"determ"`
	Diagonal fields.ValInt `json:"diagonal"`
	Eurocode fields.ValText `json:"eurocode"`
	Filter_film SupplierItem_import_item_filter_film `json:"filter_film"`
	Fixture fields.ValBool `json:"fixture"`
	Full_heating SupplierItem_import_item_full_heating `json:"full_heating"`
	Glass_color SupplierItem_import_item_glass_color `json:"glass_color"`
	Glass_packet fields.ValBool `json:"glass_packet"`
	Heated_wipers SupplierItem_import_item_heated_wipers `json:"heated_wipers"`
	Heating fields.ValBool `json:"heating"`
	Holes fields.ValInt `json:"holes"`
	Installation SupplierItem_import_item_installation `json:"installation"`
	Mirror fields.ValBool `json:"mirror"`
	Moulding SupplierItem_import_item_moulding `json:"moulding"`
	Oem fields.ValText `json:"oem"`
	Original fields.ValBool `json:"original"`
	Polarising_film fields.ValBool `json:"polarising_film"`
	Position SupplierItem_import_item_position `json:"position"`
	Rain_sensor SupplierItem_import_item_rain_sensor `json:"rain_sensor"`
	Sensors SupplierItem_import_item_sensors `json:"sensors"`
	Side SupplierItem_import_item_side `json:"side"`
	Silk_screen fields.ValBool `json:"silk_screen"`
	Sliding fields.ValBool `json:"sliding"`
	Stop_light fields.ValBool `json:"stop_light"`
	Tinting fields.ValBool `json:"tinting"`
	Triplex SupplierItem_import_item_triplex `json:"triplex"`
	Vin_window SupplierItem_import_item_vin_window `json:"vin_window"`
	Weight fields.ValFloat `json:"weight"`
	Weight_gross fields.ValInt `json:"weight_gross"`
	Weight_net fields.ValInt `json:"weight_net"`
	Wheel_pos SupplierItem_import_item_wheel_pos `json:"wheel_pos"`
	Width fields.ValInt `json:"width"`
	*/
}

type SupplierItem_import_item struct {
	Make string `json:"make"`
	Model string `json:"model"`
	Model_generation string `json:"model_generation"`
	Body string `json:"body"`
	Supplier string `json:"supplier"`
	Name string `json:"name"`
	Picture string `json:"picture"` //base64 encoded picture
	Sale_price float64 `json:"sale_price"`
	Cost float64 `json:"cost"`
	Options []SupplierItem_import_item_feature `json:"options"`
}

type SupplierItem_import struct {
	Items []SupplierItem_import_item `json:"items"`
}
type SupplierItem_import_argv struct {
	Argv *SupplierItem_import `json:"argv"`	
}

