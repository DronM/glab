package main

import (
	"os"
	"io/ioutil"
	"encoding/json"
	"fmt"
	"context"
	"strconv"
	"strings"
	"net/http"
	
	"github.com/jackc/pgx/v5"
)

const QUOTE_CHAR byte = 34

const SUPPLIER_ID = 35 //3 - agc 35 Сулимов
const MANUFACTURER_ID = 2//5 - agc 2 - KMK
const FILE_NAME = "DB_KMK-2_ONLY_JSON.json" //"DB_AGC2.json" //"test.json" //

const (
	CONN_STRING = "postgresql://glab:159753@192.168.1.177:5432/glab"
	
	STORE_QUERY_TMPL = `INSERT INTO supplier_store_values (supplier_store_id, supplier_item_id, val)
		VALUES ($1, $2, $3) ON CONFLICT (supplier_store_id, supplier_item_id) DO UPDATE
		SET val = $3`
		
	FEATURE_QUERY_TMPL = `INSERT INTO item_feature_vals (item_feature_id, item_id, val)
		VALUES ($1, $2, $3) ON CONFLICT (item_id, item_feature_id) DO UPDATE
		SET val = $3, date_time = now()`
		
	FEATURE_QUERY_DEL = `DELETE FROM item_feature_vals WHERE item_feature_id = $1 AND item_id = $2`

	SUPPLIER_FEATURE_QUERY_TMPL = `INSERT INTO supplier_item_feature_vals (item_feature_id, supplier_item_id, val)
		VALUES ($1, $2, $3) ON CONFLICT (supplier_item_id, item_feature_id) DO UPDATE
		SET val = $3, date_time = now()`
		
	SUPPLIER_FEATURE_QUERY_DEL = `DELETE FROM supplier_item_feature_vals WHERE item_feature_id = $1 AND supplier_item_id = $2`
		
)

func ExtRemoveQuotes(extVal []byte) string {
	var v_str string
	if extVal[0] == QUOTE_CHAR && byte(extVal[len(extVal)-1]) ==  QUOTE_CHAR {
		v_str = string(extVal[1:len(extVal)-1])
	}else {
		v_str = string(extVal)
	}
	return v_str
}

type BoolStr bool
func (v *BoolStr) UnmarshalJSON(data []byte) error {
	v_str := ExtRemoveQuotes(data)
	*v = (v_str == `true` || v_str == `yes` || v_str == `1` || v_str == `да`|| v_str == `антенна` ||
		v_str == `HUD`||
		v_str == `Эра-Глонасс`||
		v_str == `молдинг`||
		v_str == `фурнитура`)
	
	return nil	
}
func (v BoolStr) String() string {
	if v {
		return "true"
	}else{
		return "false"
	}
}

//int to string
type ArtikulInt string
func (v *ArtikulInt) UnmarshalJSON(data []byte) error {
	*v = ArtikulInt(string(data))
	
	return nil	
}

//string to float
type FloatStr float32
func (v *FloatStr) UnmarshalJSON(data []byte) error {
	v_str := ExtRemoveQuotes(data)
	if v_str == "" || v_str == `н.д.` || v_str == `нет` || v_str == `-` {
		return nil
	}
	
	v_str = strings.Replace(v_str, ",", ".", 1)	
	temp, err := strconv.ParseFloat(v_str, 32)
	if err != nil {
		return err
	}
	*v = FloatStr(temp)
	
	return nil	
}
func (v FloatStr) String() string {
	return fmt.Sprintf("%f", v)
}


//string to int
type IntStr int32
func (v *IntStr) UnmarshalJSON(data []byte) error {
	v_str := strings.TrimSpace(ExtRemoveQuotes(data))
	if v_str == "" || v_str == `н.д.` {
		return nil
	}
	
	temp, err := strconv.Atoi(v_str)
	if err != nil {
		return err
	}
	*v = IntStr(temp)
	
	return nil	
}
func (v IntStr) String() string {
	return fmt.Sprintf("%d", v)
}

//string to string
type StringStr string
func (v *StringStr) UnmarshalJSON(data []byte) error {
	v_str := strings.TrimSpace(ExtRemoveQuotes(data))
	if v_str == "" || v_str == `н.д.` {
		return nil
	}
	
	*v = StringStr(v_str)
	
	return nil	
}
func (v StringStr) String() string {
	return string(v)
}

type Item struct {
	Id string `json:"id"`
	
	Item_id int
	Supplier_item_id int
	
	Supplier string `json:"поставщик"`
	Supplier_id int
	
	Kind string `json:"вид"`
	Subkind string `json:"подвид"`
	Folder_id int
	
	Eurocode string `json:"еврокод"`
	Artikul ArtikulInt `json:"артикул"`
	
	Manufacturer string `json:"производитель"`
	Manufacturer_id int
	
	Brand string `json:"бренд"`
	Manufacturer_brand_id int
	Brand_id int
	
	Options_original string `json:"оригинал"`
	Options_width FloatStr `json:"габариты_ширина"`
	Options_brutto_height FloatStr `json:"габариты_высота_брутто"`
	Options_netto_height FloatStr `json:"габариты_высота_нетто"`
	Options_diagonal FloatStr `json:"габариты_диагональ"`
	Options_thickness FloatStr `json:"габариты_толщина"`
	Options_weight FloatStr `json:"габариты_вес"` //!!! to float
	Cost FloatStr `json:"цены_закуп"` //!!! to float
	Price FloatStr `json:"цены_РРЦ"` //!!! to float
	
	Sklad1 string `json:"наличие_1(Москва)"`
	Sklad2 string `json:"наличие_2(Москва_Север)"`
	Sklad3 string `json:"наличие_3(Санкт_Петербург)"`
	Sklad4 string `json:"наличие_4(Нижний_Новгород)"`
	Sklad5 string `json:"наличие_5(Казань)"`
	Sklad6 string `json:"наличие_6(Бор)"`
	Sklad7 string `json:"наличие_7(Ростов)"`
	Sklad8 string `json:"наличие_8(Краснодар)"`
	Sklad9 string `json:"наличие_9(Екатеринбург)"`
	Sklad10 string `json:"наличие_10(Новосибирск)"`
	Sklad11 string `json:"наличие_11"`
	Sklad12 string `json:"наличие_12"`
	Sklad13 string `json:"наличие_13"`
	Sklad14 string `json:"наличие_14"`
	Sklad15 string `json:"наличие_15"`
	
	Pict1 string `json:"изображение_1"`
	Pict2 string `json:"изображение_2"`
	Pict3 string `json:"изображение_3"`
	Pict4 string `json:"изображение_4"`
	Pict5 string `json:"изображение_5"`
	Pict6 string `json:"изображение_6"`
	Pict7 string `json:"изображение_7"`
	Pict8 string `json:"изображение_8"`
	Photo1 string `json:"фото_1"`
	Photo2 string `json:"фото_2"`
	Photo3 string `json:"фото_3"`
	Photo4 string `json:"фото_4"`
	Photo5 string `json:"фото_5"`
	Photo6 string `json:"фото_6"`
	Photo7 string `json:"фото_7"`
	
	Comment_text string `json:"комменты_текст"`
	Comment_note StringStr `json:"комменты_примечание"`
	
	Options_triplex string `json:"свойства_стекла_технология"`
	Options_silk_screen string `json:"свойства_стекла_шелкография"`	
	Options_side string `json:"свойства_стекла_место_сторона"`
	Options_position string `json:"свойства_стекла_место_расположено"`
	Options_fixing string `json:"свойства_стекла_фиксация"`
	Options_rain_sensor string `json:"свойства_стекла_формаДД"`
	Options_moulding string `json:"свойства_стекла_формамолдинга"`
	Options_camera string `json:"свойства_стекла_камеры_ассистенты"`
	Options_cam_calib string `json:"свойства_стекла_камеры_калибровка"`
	Options_glass_color string `json:"цвет_стекла"`
	Options_filter_film_color string `json:"цвет_полосы"`
	Options_type_color string `json:"цвет_свойства"`
	Options_descr_color string `json:"цвет_описание"`
	Options_sensors string `json:"опции_датчики"`
	Options_heated_wipers string `json:"опции_обогревщетокикамер"`
	Options_full_heating string `json:"опции_полныйобогрев"`
	Options_cam_options string `json:"опции_камеры"`
	Options_antenna BoolStr `json:"опции_антенна"`
	
	Options_wheel_pos string `json:"опции_руль"`
	
	Options_polarising_film BoolStr `json:"опции_проекция"`
	
	Options_vin_window string `json:"опции_окноподVIN"`
	
	Options_glonass BoolStr `json:"опции_ЭраГлонасс"`  //bool
	
	Options_capsule BoolStr `json:"опции_молдинг"`  //bool
	
	Options_accessories BoolStr `json:"опции_фурнитура"`
	
	Options_holes string `json:"опции_отверстия"`
	
	Options_other string `json:"опции_прочие"`
	Options_all_options string `json:"опции_полныйсписок"`
	Options_analogues string `json:"аналоги_еврокоды"`
	Options_oem string `json:"ОЕМ_OES"`
	Auto_base_model string `json:"автомобили_период_базовыемодели"`
	Auto_base_body string `json:"автомобили_период_базовыйкузов"`
	Auto_period_from IntStr `json:"автомобили_период_старт"`
	Auto_period_to IntStr `json:"автомобили_период_финиш"`
	Auto_analogues string `json:"автомобили_аналоги"`
	Auto_make string `json:"автомобили_марка"`
	Auto_model string `json:"автомобили_модель"`
	Auto_body_period IntStr `json:"автомобили_период_кузова"`
	Auto_period_begin IntStr `json:"автомобили_период_начало"`
	Auto_period_end IntStr `json:"автомобили_период_конец"`
}

type Items map[string]Item

type ManBrand struct {
	Brand_id int
	Manufacturer_id int
}

type ItemPicture struct {
	SupplierItemID int
	Url string
	PictID string
	PictName string
}

func load_picture(itemIn <-chan ItemPicture, workerID string) {
	var conn *pgx.Conn
	for {
		select {
		case it := <- itemIn:
			resp, err := http.Get(it.Url)
			if err != nil {
				fmt.Printf("Error load_picture http.Get(): %v\n", err)
				continue
			}
			if resp.StatusCode != 200 {
				fmt.Printf("Error load_picture StatusCode: %d\n", resp.StatusCode)
				continue
			}
			defer resp.Body.Close()
			pict_d, err := ioutil.ReadAll(resp.Body) //
			if err != nil {
				fmt.Printf("Error load_picture ioutil.ReadAll(): %v\n", err)
				continue
			}
			if conn == nil {
				var err error
				conn, err = pgx.Connect(context.Background(), CONN_STRING)
				if err != nil {
					fmt.Printf("Error load_picture pgx.Connect(): %v\n", err)
					continue					
				}
			}
			//fmt.Println("Adding to attachments", workerID, "Len:", len(pict_d))
			
			att_id := 0
			if err := conn.QueryRow(context.Background(),
				fmt.Sprintf(`SELECT id FROM attachments
					WHERE ref->>'dataType' = 'supplier_items' AND (ref->'keys'->>'id')::int = %d AND content_info->>'id' = '%s'`, it.SupplierItemID, it.PictID),
			).Scan(&att_id); err != nil && err != pgx.ErrNoRows {
				fmt.Printf("Error load_picture SELECT conn.QueryRow(): %v\n", err)
				continue					
				
			}else if err != nil && err == pgx.ErrNoRows {
				if _, err := conn.Exec(context.Background(),
					fmt.Sprintf(`INSERT INTO attachments (ref, content_info, content_data)
						VALUES
						('{"keys": {"id": %d}, "dataType": "supplier_items"}'::jsonb,
						'{"id": "%s", "name": "%s", "size": %d}'::jsonb,
						$1)`, it.SupplierItemID, it.PictID, it.PictName, len(pict_d)),
						pict_d,
				); err != nil {
					fmt.Printf("Error load_picture INSERT conn.Exec(): %v\n", err)
					continue					
				}			
			}else{
				if _, err := conn.Exec(context.Background(),
					fmt.Sprintf(`UPDATE attachments
						SET
							content_data = $1,
							content_info = content_info || '{"name": "%s", "size": %d}'::jsonb
						WHERE ref->>'dataType' = 'supplier_items' AND (ref->'keys'->>'id')::int = %d AND content_info->>'id' = '%s'`,
						it.PictName, len(pict_d), it.SupplierItemID, it.PictID),
						pict_d,
				); err != nil {
					fmt.Printf("Error load_picture UPDATE conn.Exec(): %v\n", err)
					continue					
				}			
				
			}
		}
	}	
}

func SetFeatureVal(conn *pgx.Conn, itemFeatures []string, features map[string]int, itemID int, featureName string, supplierItemID int, featureVal string) error {
	is_item_feature := false
	for _, it_f := range itemFeatures {
		if it_f == featureName {
			is_item_feature = true
			break
		}
	}
	var feature_query string
	var feature_del_query string
	var query_item_id int
	if is_item_feature {
		feature_query = FEATURE_QUERY_TMPL
		feature_del_query = FEATURE_QUERY_DEL
		query_item_id = itemID
	}else{
		feature_query = SUPPLIER_FEATURE_QUERY_TMPL
		feature_del_query = SUPPLIER_FEATURE_QUERY_DEL	
		query_item_id = supplierItemID
	}
	feature_id := features[featureName]
	if featureVal == "н.д." || featureVal == "нет" || featureVal == "" || featureVal == "false" {
		_, err := conn.Exec(context.Background(), feature_del_query, feature_id, query_item_id)
		return err
	}
	_, err := conn.Exec(context.Background(), feature_query, feature_id, query_item_id, featureVal)
	if err != nil {
fmt.Println("SetFeatureVal ERROR")	
fmt.Println(feature_query)
fmt.Println(feature_id, query_item_id, featureVal)
		return err
	}
	return err
}

func main(){
	file, err := os.Open(FILE_NAME)
	if err != nil {
		panic(err)
	}
	defer file.Close()
	
	byte_v, err := ioutil.ReadAll(file)
	if err != nil {
		panic(err)
	}
	
	var items Items
	if err := json.Unmarshal(byte_v, &items); err != nil {
		panic(err)
	}
	
	conn, err := pgx.Connect(context.Background(), CONN_STRING)
	if err != nil {
		panic(err)
	}
	defer conn.Close(context.Background())
		
	brands := make(map[string]ManBrand)
	suppliers := make(map[string]int)
	
	//
	groups := map[string]string{"иномарки_ветровое": "1110",
		"иномарки_боковое": "1130",
		"иномарки_заднее": "1120",
		"грузовые_ветровое": "1310",
		"грузовые_боковое": "1320",
		"грузовые_заднее": "1330",
		"коммерция_ветровое": "1410",
		"коммерция_боковое": "1430",
		"коммерция_заднее": "1420",
		"коммерция_внутреннее": "1450",
		"отечка_заднее": "1220",
		"отечка_боковое": "1230",
		"отечка_ветровое": "1210",
		"спецтехника_ветровое":"1511",
		"спецтехника_боковое":"1512",
		"спецтехника_заднее":"1513",
		
		"иномарки_кунги":"17",
		"отечка_кунги":"17",
		"коммерция_кунги":"17",
		"спецтехника_кунги":"17",
		"грузовые_кунги":"17",
		
		"иномарки_крыши":"16",
		"отечка_крыши":"16",
		"коммерция_крыши":"16",
		"спецтехника_крыши":"16",
		"грузовые_крыши":"16",
	}
	
	//stores
	stores := make(map[string]int)
	rows, err := conn.Query(context.Background(), "SELECT id, name_api FROM supplier_stores WHERE supplier_id = $1", SUPPLIER_ID)
	if err != nil {
		panic(err)
	}
	for rows.Next() {		
		var store_id int
		var store_name string
		if err := rows.Scan(&store_id, &store_name); err != nil {		
			panic(err)
		}
		stores[store_name] = store_id
	}
	if err := rows.Err(); err != nil {
		panic(err)
	}
	rows.Close()
	
	//features, просто список всех опций ид/латинское название для поиска
	features := make(map[string]int)
	rows, err = conn.Query(context.Background(), "SELECT id, name_lat FROM item_features")
	if err != nil {
		panic(err)
	}
	for rows.Next() {		
		var feature_id int
		var feature_name string
		if err := rows.Scan(&feature_id, &feature_name); err != nil {		
			panic(err)
		}
		features[feature_name] = feature_id
	}
	if err := rows.Err(); err != nil {
		panic(err)
	}
	rows.Close()
	
	//Списки фильтруемых (Item) свойств для каждой папки
	//Ключ = Ид группы it.Folder_id
	//Значение = список латинских знаечний свойств, ид взять в features
	gr_item_features := make(map[int][]string, 0)
	
	//loading pictures
	pict_for_load := make(chan ItemPicture)
	go func(){
		load_picture(pict_for_load, "1")
	}()
	go func(){
		load_picture(pict_for_load, "2")
	}()
	go func(){
		load_picture(pict_for_load, "3")
	}()
	go func(){
		load_picture(pict_for_load, "4")
	}()
	go func(){
		load_picture(pict_for_load, "5")
	}()
	go func(){
		load_picture(pict_for_load, "6")
	}()
	go func(){
		load_picture(pict_for_load, "7")
	}()
	go func(){
		load_picture(pict_for_load, "8")
	}()
	
	for _, it := range items {
		
		//suppliers
		if it.Supplier == "" || it.Supplier == "н.д." {
			fmt.Println("No Supplier ID:", it.Id)
			continue
		}
		if supplier_id, ok := suppliers[it.Supplier]; !ok {
			if err := conn.QueryRow(context.Background(),
				"SELECT id FROM suppliers WHERE name = $1", it.Supplier,
			).Scan(&it.Supplier_id); err != nil {
				fmt.Println("Supplier not found by name", it.Supplier)
				continue
			}
			suppliers[it.Supplier] = it.Supplier_id
		}else{
			it.Supplier_id = supplier_id
		}

		
		//brands	
		it.Manufacturer_id = MANUFACTURER_ID
		if brand, ok := brands[it.Brand]; !ok {
			if err := conn.QueryRow(context.Background(),
				"SELECT id, manufacturer_id FROM manufacturer_brands WHERE name = $1", it.Brand,
			).Scan(&it.Brand_id, &it.Manufacturer_id); err != nil {
				fmt.Println("Brand not found by name", it.Brand)				
				continue
			}
			brands[it.Brand] = ManBrand{Brand_id: it.Brand_id, Manufacturer_id: it.Manufacturer_id}
		}else{
			it.Brand_id = brand.Brand_id
			it.Manufacturer_id = brand.Manufacturer_id
		}
		
		//определить группу товара
		gr := it.Kind + "_" + it.Subkind
		gr_code, gr_code_exists := groups[gr]
		if !gr_code_exists {
			fmt.Println("Group not found:", gr)
		}
		if err := conn.QueryRow(context.Background(),
			"SELECT id FROM item_folders WHERE code = $1", gr_code,
		).Scan(&it.Folder_id); err != nil {
			panic(err)
		}
		
		item_features, ok := gr_item_features[it.Folder_id]
		if !ok {
			//первый раз встречается группа
			rows, err = conn.Query(context.Background(),
				fmt.Sprintf(`SELECT
					f.name_lat
				FROM item_folder_feature_groups AS g
				LEFT JOIN item_feature_group_items AS f_g_it ON f_g_it.item_feature_group_id = g.item_feature_group_id
				LEFT JOIN item_features AS f ON f.id = f_g_it.item_feature_id
				WHERE g.item_folder_id = %d
				ORDER BY f_g_it.code`, it.Folder_id),			
			)
			if err != nil {
				panic(err)
			}	
			gr_item_features[it.Folder_id] = make([]string, 0)		
			for rows.Next() {		
				var feature_name string
				if err := rows.Scan(&feature_name); err != nil {		
					panic(err)
				}
				gr_item_features[it.Folder_id] = append(gr_item_features[it.Folder_id], feature_name)
			}
			if err := rows.Err(); err != nil {
				panic(err)
			}
			rows.Close()			
			item_features,_ = gr_item_features[it.Folder_id]
		}
		
		//supplier_item
		if err := conn.QueryRow(context.Background(),
			"SELECT id, item_id FROM supplier_items WHERE supplier_item_id = $1", it.Id,
		).Scan(&it.Supplier_item_id, &it.Item_id); err != nil && err != pgx.ErrNoRows {
			//new item
			panic(err)
						
		}else if err != nil && err == pgx.ErrNoRows {
			//no item - new item
			//Поиск номенклатуры по папке + свойства (фильтруемые)
			
			var item_feature_val_conc strings.Builder
			for i, item_feature := range item_features {
				item_feature_val := ""
				switch item_feature {
				case "original":
					item_feature_val = it.Options_original
				case "width":
					item_feature_val = it.Options_width.String()
				case "brutto_height":
					item_feature_val = it.Options_brutto_height.String()
				case "netto_height":
					item_feature_val = it.Options_netto_height.String()
				case "diagonal":
					item_feature_val = it.Options_diagonal.String()
				case "thickness":
					item_feature_val = it.Options_thickness.String()
				case "weight":
					item_feature_val = it.Options_weight.String()
				case "triplex":
					item_feature_val = it.Options_triplex
				case "silk_screen":
					item_feature_val = it.Options_silk_screen
				case "side":
					item_feature_val = it.Options_side
				case "position":
					item_feature_val = it.Options_position
				case "fixing":
					item_feature_val = it.Options_fixing
				case "rain_sensor":
					item_feature_val = it.Options_rain_sensor
				case "moulding":
					item_feature_val = it.Options_moulding
				case "camera":
					item_feature_val = it.Options_camera
				case "cam_calib":
					item_feature_val = it.Options_cam_calib
				case "glass_color":
					item_feature_val = it.Options_glass_color
				case "filter_film_color":
					item_feature_val = it.Options_filter_film_color
				case "type_color":
					item_feature_val = it.Options_type_color
				case "descr_color":
					item_feature_val = it.Options_descr_color
				case "sensors":
					item_feature_val = it.Options_sensors
				case "heated_wipers":
					item_feature_val = it.Options_heated_wipers
				case "full_heating":
					item_feature_val = it.Options_full_heating
				case "cam_options":
					item_feature_val = it.Options_cam_options
				case "antenna":
					item_feature_val = it.Options_antenna.String()
				case "wheel_pos":
					item_feature_val = it.Options_wheel_pos
				case "polarising_film":
					item_feature_val = it.Options_polarising_film.String()
				case "vin_window":
					item_feature_val = it.Options_vin_window
				case "glonass":
					item_feature_val = it.Options_glonass.String()
				case "capsule":
					item_feature_val = it.Options_capsule.String()
				case "accessories":
					item_feature_val = it.Options_accessories.String()
				case "holes":
					item_feature_val = it.Options_holes
				case "other":
					item_feature_val = it.Options_other
				case "all_options":
					item_feature_val = it.Options_all_options
				case "analogues":
					item_feature_val = it.Options_analogues
				case "oem":
					item_feature_val = it.Options_oem
				}
				if item_feature_val == "н.д." || item_feature_val == "нет" || item_feature_val == "false" {
					continue
				}
				if i > 0 {
					item_feature_val_conc.WriteString(";")	
				}
				item_feature_val_conc.WriteString(item_feature + "=" + item_feature_val)
			}
//fmt.Println(item_feature_val_conc.String())			
//			break
			
			item_feature_val_conc_s := item_feature_val_conc.String()
			if err := conn.QueryRow(context.Background(),
				`SELECT id FROM items WHERE feature_vals = $1`, item_feature_val_conc_s,
				).Scan(&it.Item_id); err != nil && err != pgx.ErrNoRows {
				
				panic(err)
				
			}else if err != nil {
				if err := conn.QueryRow(context.Background(),
					`INSERT INTO items (item_folder_id, manufacturer_id, manufacturer_brand_id, feature_vals) VALUES ($1, $2, $3, $4)
					RETURNING id`,
					it.Folder_id, it.Manufacturer_id, it.Brand_id, item_feature_val_conc_s,
				).Scan(&it.Item_id); err != nil {

					panic(err)
				}				
			}
			
			
		}
//break
		//insert/update
		if err := conn.QueryRow(context.Background(),
			`INSERT INTO supplier_items
			(item_id, supplier_id, supplier_item_id, cost, sale_price, artikul, comment_text, comment_note)
			VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
			ON CONFLICT (supplier_item_id) DO UPDATE
			SET
				cost = $4,
				sale_price = $5,
				artikul = $6,
				comment_text = $7,
				comment_note = $8,
				modified_dt = now()
			RETURNING id`,
			it.Item_id,
			it.Supplier_id,
			it.Id,
			it.Cost,
			it.Price,
			it.Artikul,
			it.Comment_text,
			it.Comment_note,
			).Scan(&it.Supplier_item_id); err != nil {
			
			panic(err)
		}
		
		//остатки
		
		//1
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_1"],
			it.Supplier_item_id,
			it.Sklad1,
		); err != nil {
			panic(err)
		}

		//2
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_2"],
			it.Supplier_item_id,
			it.Sklad2,
		); err != nil {
			panic(err)
		}

		//3
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_3"],
			it.Supplier_item_id,
			it.Sklad3,
		); err != nil {
			panic(err)
		}
		
		//4
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_4"],
			it.Supplier_item_id,
			it.Sklad4,
		); err != nil {
			panic(err)
		}

		//5
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_5"],
			it.Supplier_item_id,
			it.Sklad5,
		); err != nil {
			panic(err)
		}

		//6
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_6"],
			it.Supplier_item_id,
			it.Sklad6,
		); err != nil {
			panic(err)
		}

		//7
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_7"],
			it.Supplier_item_id,
			it.Sklad7,
		); err != nil {
			panic(err)
		}

		//8
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_8"],
			it.Supplier_item_id,
			it.Sklad8,
		); err != nil {
			panic(err)
		}

		//9
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_9"],
			it.Supplier_item_id,
			it.Sklad9,
		); err != nil {
			panic(err)
		}

		//10
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_10"],
			it.Supplier_item_id,
			it.Sklad10,
		); err != nil {
			panic(err)
		}

		//11
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_11"],
			it.Supplier_item_id,
			it.Sklad11,
		); err != nil {
			panic(err)
		}

		//12
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_12"],
			it.Supplier_item_id,
			it.Sklad12,
		); err != nil {
			panic(err)
		}

		//13
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_13"],
			it.Supplier_item_id,
			it.Sklad13,
		); err != nil {
			panic(err)
		}

		//14
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_14"],
			it.Supplier_item_id,
			it.Sklad14,
		); err != nil {
			panic(err)
		}

		//15
		if _, err := conn.Exec(context.Background(),
			STORE_QUERY_TMPL,
			stores["склад_15"],
			it.Supplier_item_id,
			it.Sklad15,
		); err != nil {
			panic(err)
		}
		
		//features
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "original", it.Supplier_item_id, it.Options_original); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "width", it.Supplier_item_id, it.Options_width.String()); err != nil {		
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "brutto_height", it.Supplier_item_id, it.Options_brutto_height.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "netto_height", it.Supplier_item_id, it.Options_netto_height.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "diagonal", it.Supplier_item_id, it.Options_diagonal.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "thickness", it.Supplier_item_id, it.Options_thickness.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "weight", it.Supplier_item_id, it.Options_weight.String()); err != nil {
			panic(err)
		}
		//
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "triplex", it.Supplier_item_id, it.Options_triplex); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "silk_screen", it.Supplier_item_id, it.Options_silk_screen); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "side", it.Supplier_item_id, it.Options_side); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "position", it.Supplier_item_id, it.Options_position); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "fixing", it.Supplier_item_id, it.Options_fixing); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "rain_sensor", it.Supplier_item_id, it.Options_rain_sensor); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "moulding", it.Supplier_item_id, it.Options_moulding); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "camera", it.Supplier_item_id, it.Options_camera); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "cam_calib", it.Supplier_item_id, it.Options_cam_calib); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "glass_color", it.Supplier_item_id, it.Options_glass_color); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "filter_film_color", it.Supplier_item_id, it.Options_filter_film_color); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "type_color", it.Supplier_item_id, it.Options_type_color); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "descr_color", it.Supplier_item_id, it.Options_descr_color); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "sensors", it.Supplier_item_id, it.Options_sensors); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "heated_wipers", it.Supplier_item_id, it.Options_heated_wipers); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "full_heating", it.Supplier_item_id, it.Options_full_heating); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "cam_options", it.Supplier_item_id, it.Options_cam_options); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "antenna", it.Supplier_item_id, it.Options_antenna.String()); err != nil {
			//panic(err)
panic(fmt.Sprintf("it.Item_id=%d, it.Supplier_item_id=%d, supplier_item_id=%s\n", it.Item_id, it.Supplier_item_id, it.Id))
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "wheel_pos", it.Supplier_item_id, it.Options_wheel_pos); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "polarising_film", it.Supplier_item_id, it.Options_polarising_film.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "vin_window", it.Supplier_item_id, it.Options_vin_window); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "glonass", it.Supplier_item_id, it.Options_glonass.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "capsule", it.Supplier_item_id, it.Options_capsule.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "accessories", it.Supplier_item_id, it.Options_accessories.String()); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "holes", it.Supplier_item_id, it.Options_holes); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "other", it.Supplier_item_id, it.Options_other); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "all_options", it.Supplier_item_id, it.Options_all_options); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "analogues", it.Supplier_item_id, it.Options_analogues); err != nil {
			panic(err)
		}
		if err := SetFeatureVal(conn, item_features, features, it.Item_id, "oem", it.Supplier_item_id, it.Options_oem); err != nil {
			panic(err)
		}
		
		//pictures
		if it.Pict1 != "" && it.Pict1 != "н.д." && it.Pict1 != "нет" {
			/*file_name
			path_parts := strings.Split(it.Pict1, "/")
			if path_parts > 0 {
				path_parts[len(path_parts)-1]
			}
			*/
			pict_for_load <- ItemPicture{SupplierItemID: it.Supplier_item_id,
				Url: it.Pict1,
				PictID: "pic_1",
				PictName: it.Pict1,
			}
		}
		
		//break
	}
}
