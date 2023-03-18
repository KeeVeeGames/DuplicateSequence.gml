if (event_data[? "event_type"] == "sequence event") {
    if (event_data[? "message"] == "Hello") {
		show_debug_message("Hello " + string(event_data[? "element_id"]));
    }
}