INSERT INTO item_feature_group_items
(item_feature_group_id, item_feature_id, code)
select
	32,
	it.item_feature_id,
	it.code
from item_feature_group_items AS it 
where it.item_feature_group_id = 19
