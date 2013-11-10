$fn = 100;

band_post_h = 7.0;
catch_w = 2.5;

post_thickness = 6.0;

wall_thickness = 2.5;
padding = 0.5;
loose_padding = 1.5 * padding;
print_spacing = 2.0;

barrel_end_l = 60.0;
barrel_extender_l = 60.0;
barrel_post_l = 30.0;

grip_h = 55.0;
grip_w = 45.0;

cocker_l = 10.0;

trigger_top_exposed_h = 15.0;
trigger_bottom_h = 10.0;
trigger_bottom_w = 6.0;

print_spacing = 2.0;

total_barrel_l = barrel_end_l + barrel_extender_l;

trigger_top_h = trigger_top_exposed_h + padding + wall_thickness;

pin_r = 3.0;
pin_cutter_r = pin_r + padding;

pin_taper_h = 2.0;
pin_lip_h = 1.0;
pin_end_h = pin_taper_h + pin_lip_h;

pin_lip_w = 1.5 * padding;

pin_notch_w = 4.0;
pin_notch_h = pin_end_h + padding + wall_thickness;

pin_h = post_thickness + (4 * padding) + (2 * wall_thickness) + (2 * pin_end_h);
pin_flat_ratio = 1 / 3.0;
pin_flat_trim_h = (pin_flat_ratio * pin_r) + pin_lip_w;
pin_flat_trim_y_offset = -pin_flat_trim_h - pin_r + (pin_flat_ratio * pin_r);

trigger_wheel_catch_r = pin_r + loose_padding + (2 * wall_thickness) + band_post_h;
trigger_wheel_r = trigger_wheel_catch_r - (2 * catch_w);

trigger_catch_r = pin_r + loose_padding + wall_thickness;
trigger_catch_lever_h = trigger_wheel_catch_r + padding - wall_thickness;

trigger_x_offset = (4 * catch_w) + wall_thickness + padding;

trigger_front = trigger_x_offset - trigger_catch_r - (2 * padding);
trigger_back = trigger_x_offset + trigger_catch_r;

trigger_forward_offset = trigger_front + 20.0;

barrel_connector_h = pin_cutter_r + (5 * wall_thickness);
barrel_connector_w = barrel_connector_h + wall_thickness;
barrel_h = barrel_connector_h + (2 * wall_thickness) + (2 * padding);

housing_h = wall_thickness + padding + (2 * trigger_catch_r) + trigger_catch_lever_h 
		+ trigger_wheel_catch_r - band_post_h;
housing_top_back = trigger_x_offset + wall_thickness + padding + (2 * trigger_wheel_r);
housing_bottom_back = housing_top_back + (0.85 * housing_h);
housing_thickness = (2 * wall_thickness) + (2 * padding) + post_thickness;
housing_connector_h = barrel_connector_h + (2 * wall_thickness) 
		+ ((post_thickness + (2 * padding)) / 2.0) + (2 * padding);
housing_connector_w = barrel_connector_w;

cross_section = true;

parts_for_design();

//all_parts_for_printing();

//trigger_parts_for_printing();

//housing_for_printing();

//barrel_for_printing();

//barrel_extender_for_printing();

module all_parts_for_printing() {
	trigger_parts_for_printing();

	translate([trigger_wheel_catch_r + (2 * (pin_r + pin_lip_w)) 
				+ (2 * print_spacing) + housing_thickness, 
			(-total_barrel_l / 2.0) + housing_connector_w, housing_h])
		rotate([-90, 0, 90])
			make_grip_and_housing();

	translate([trigger_wheel_catch_r + (2 * (pin_r + pin_lip_w)) + print_spacing -wall_thickness, 
			-pin_h - (2 * print_spacing), 0])
		rotate([90, -90, 0])
			make_barrel(barrel_end_l, end_piece=true);

	translate([trigger_wheel_catch_r + (2 * (pin_r + pin_lip_w)) + print_spacing -wall_thickness, 
			-pin_h - (3 * print_spacing) - housing_thickness, 0])
		rotate([90, -90, 0])
			make_barrel(barrel_extender_l, end_piece=false);
};

module barrel_for_printing() {
	translate([housing_thickness / 2.0, -barrel_h / 2.0, 0])
		rotate([0, -90, 0])
			make_barrel(barrel_end_l, end_piece=true);
	
	translate([(housing_thickness / 2.0) + pin_r + pin_lip_w + print_spacing, 0, 0])
		make_pin();
};

module barrel_extender_for_printing() {
	translate([housing_thickness / 2.0, -barrel_h / 2.0, 0])
		rotate([0, -90, 0])
			make_barrel(barrel_extender_l, end_piece=false);
	
	translate([(housing_thickness / 2.0) + pin_r + pin_lip_w + print_spacing, 0, 0])
		make_pin();
};

module housing_for_printing() {
	translate([housing_thickness / 2.0, 
			(-total_barrel_l / 2.0) + housing_connector_w, housing_h])
		rotate([-90, 0, 90])
			make_grip_and_housing();
};

module trigger_parts_for_printing() {
	translate([0, trigger_wheel_r + trigger_catch_r + trigger_catch_lever_h + print_spacing, 0])
		rotate([0, 0, -90])
			make_trigger_wheel();

	make_trigger();

	translate([pin_r + pin_lip_w + trigger_wheel_catch_r + print_spacing, 0, 0]) {
		translate([0, (pin_h + print_spacing) / 2.0, 0])
			make_pin();

		translate([0, -(pin_h + print_spacing) / 2.0, 0])
			make_pin();

		translate([0, ((pin_h + print_spacing) / 2.0) + pin_h + print_spacing, 0])
			make_pin();

		translate([0, ((pin_h + print_spacing) / 2.0) + (2 * (pin_h + print_spacing)), 0])
			make_pin();
	};
};

module parts_for_design() {
	translate([trigger_x_offset, trigger_catch_r + padding + wall_thickness, 0]) {
		translate([trigger_wheel_r, trigger_catch_r + trigger_catch_lever_h, 0]) {
			color("green")
				translate([0, 0, wall_thickness + padding])
					rotate([0, 0, 90])
						make_trigger_wheel();

			// trigger wheel pin
			translate([0, 0, -(2 * padding)])
				rotate([0, 0, -45])
					rotate([-90, 0, 0])
						translate([0, -(pin_h / 2.0) + wall_thickness, 
								-pin_r + (pin_flat_ratio * pin_r)])
							make_pin();
		}

		color("red")
			translate([0, 0, wall_thickness + padding])
				rotate([0, 0, 20])
					make_trigger();

		// trigger pin
		translate([0, 0, -(2 * padding)])
			rotate([0, 0, -45])
				rotate([-90, 0, 0])
					translate([0, -(pin_h / 2.0) + wall_thickness, 
							-pin_r + (pin_flat_ratio * pin_r)])
						make_pin();
	};

	color("yellow")
		difference() {
			make_grip_and_housing();

			if (cross_section) {
				translate([-housing_connector_w - 0.5, -grip_h - 0.5, housing_thickness / 2.0])
					cube([housing_top_back + (0.85 * housing_h) 
							+ housing_connector_w + (2 * grip_w) + 1.0, 
							housing_h + grip_h + 1.0, housing_thickness / 2.0 + 1.0]);
			}
		};

	translate([-total_barrel_l - barrel_connector_w - (2 * padding), 
			housing_h - barrel_h - padding + wall_thickness + padding, 0]) {
		color("yellow")
			difference() {
				union() {
					make_barrel(barrel_end_l, end_piece=true);

					translate([barrel_end_l + padding, 0, 0])
						make_barrel(barrel_extender_l, end_piece=false);	
				}
		
				if (cross_section) {
					translate([-0.5, -5.0, (housing_thickness / 2.0) + 1])
						cube([total_barrel_l + barrel_connector_w + 2.0, 
								barrel_h + band_post_h + 10.0, 
								(housing_thickness / 2.0) + 1.0]);
				}
			}
	}

	// barrel pin
	translate([-pin_cutter_r - (2 * wall_thickness) - padding,
			housing_h - pin_cutter_r - (3 * wall_thickness), 0])
		translate([0, 0, -(2 * padding)])
			rotate([0, 0, 45])
				rotate([-90, 0, 0])
					translate([0, -(pin_h / 2.0) + wall_thickness, 
							-pin_r + (pin_flat_ratio * pin_r)])
						make_pin();

	// barrel extender pin
	translate([-pin_cutter_r - (2 * wall_thickness) - (2 * padding) - barrel_extender_l,
			housing_h - pin_cutter_r - (3 * wall_thickness), 0])
		translate([0, 0, -(2 * padding)])
			rotate([0, 0, 45])
				rotate([-90, 0, 0])
					translate([0, -(pin_h / 2.0) + wall_thickness, 
							-pin_r + (pin_flat_ratio * pin_r)])
						make_pin();
};

module make_barrel(length, end_piece=true) {
	difference() {
		union() {
			// main barrel
			translate([0, -wall_thickness, 0])
				cube([length, barrel_h, housing_thickness]);

			if (end_piece) {
				// band post
				translate([0, barrel_connector_h + wall_thickness, wall_thickness + padding])
					linear_extrude(height=post_thickness)
						polygon([
								[0, -1.0],
								[0, band_post_h + 1.0],
								[barrel_post_l, -1.0]
							]);
			}

			// connector
			translate([length - 1.0, padding, wall_thickness + padding])
				cube([barrel_connector_w + 1.0, barrel_connector_h, post_thickness]);
		}
	
		// cut pin hole
		translate([length + barrel_connector_w - pin_cutter_r - (2 * wall_thickness),
				pin_cutter_r + (2 * wall_thickness), -0.5])
			rotate([0, 0, 90])
				make_pin_cutter(housing_thickness + 1.0);

		// cut barrel interior 
		translate([-wall_thickness, -wall_thickness, 0])
			union() {
				translate([length - ((housing_thickness - (2 * wall_thickness)) / 2.0), 
						wall_thickness, wall_thickness])
					make_angle_cutter(barrel_h - (2 * wall_thickness), 
							housing_thickness - (2 * wall_thickness));

				translate([0, wall_thickness, wall_thickness])
					cube([length - ((housing_thickness - (2 * wall_thickness)) / 2.0), 
							barrel_h - (2 * wall_thickness),
							housing_thickness - (2 * wall_thickness)]);
			}

		
		if (!end_piece) {
			// cut pin hole
			translate([pin_cutter_r + (2 * wall_thickness) + (2 * padding),
					pin_cutter_r + (2 * wall_thickness), -0.5])
				rotate([0, 0, 90])
					make_pin_cutter(housing_thickness + 1.0);
		}
	}
};

module make_grip_and_housing() {
	difference() {
		union() {
			difference() {
				// blank grip and housing
				make_grip_housing_blank();

				// hollow out grip and housing
				translate([0, 0, wall_thickness])
					make_grip_housing_blank(extra=wall_thickness);
			}

			translate([-housing_connector_w, housing_h - housing_connector_h, 0]) {
				difference() {
					// main cnnector
					cube([housing_connector_w + 1.0, housing_connector_h, housing_thickness]);

					// hollow out connector
					translate([-1.0, 
							housing_connector_h - barrel_connector_h - wall_thickness - (2 * padding), 
							wall_thickness])
						union() {
							cube([housing_connector_w + 1.0, barrel_connector_h + (2 * padding), 
									housing_thickness - (2 * wall_thickness)]);
		
							translate([housing_connector_w + 1.0, 0, 0])
								rotate([0, 0, 90])
									make_angle_cutter(housing_connector_w + 1.0, 
											housing_thickness - (2 * wall_thickness));
						}
				}
			}
		}

		// cut trigger group hollow
		translate([0, 0, wall_thickness])
			linear_extrude(height=housing_thickness - (2 * wall_thickness))
				polygon([
						[wall_thickness, -0.5],
						[wall_thickness, housing_h + 0.5],
						[housing_top_back + wall_thickness, housing_h + 0.5],
						[trigger_forward_offset, -0.5]
					]);

		// cut notch for trigger angle
		translate([(4 * wall_thickness) + trigger_forward_offset + 0.5, 0, wall_thickness])
			union() {
				rotate([0, 0, 90])
					make_angle_cutter((4 * wall_thickness) + 1.0, 
							housing_thickness - (2 * wall_thickness));

				translate([-(4 * wall_thickness) - 1.0, 0, 0])
					cube([(4 * wall_thickness) + 1.0, 2 * wall_thickness, 
							housing_thickness - (2 * wall_thickness)]);
			}

		// cut notch for cocking lever
		translate([wall_thickness, housing_h - (2.5 * wall_thickness), wall_thickness])
			union() {
				cube([housing_bottom_back, 2.5 * wall_thickness + 0.5, 
						housing_thickness - (2 * wall_thickness)]);
		
				translate([housing_bottom_back, 0, 0])
					rotate([0, 0, 90])
						make_angle_cutter(housing_bottom_back, 
								housing_thickness - (2 * wall_thickness));
			}

		// cut trigger pin hole
		translate([trigger_x_offset, trigger_catch_r + padding + wall_thickness, -0.5])
			make_pin_cutter(housing_thickness + 1.0);

		// cut trigger catch wheel pin hole
		translate([trigger_x_offset + trigger_wheel_r, 
				(2 * trigger_catch_r) + padding + wall_thickness + trigger_catch_lever_h, -0.5])
			make_pin_cutter(housing_thickness + 1.0);

		// cut barrel connector pin hole
		translate([-pin_cutter_r - padding - (2 * wall_thickness), 
				housing_h - pin_cutter_r - (barrel_connector_h / 2.0) + padding, -0.5])
			rotate([0, 0, 90])
				make_pin_cutter(housing_thickness + 1.0);
	};
};

module make_grip_housing_blank(extra=0) {
	linear_extrude(height=housing_thickness - (2 * extra))
		polygon([
				[extra, extra],
				[extra, housing_h - extra],
				[housing_top_back - extra, housing_h - extra],
				[housing_bottom_back - extra, -extra],
				[housing_bottom_back + grip_w - extra, -grip_h - (extra / 10.0)],
				[housing_top_back + (0.65 * housing_h) + extra, -grip_h - (extra / 10.0)],
				[trigger_forward_offset + extra, extra]
			]);
};

module make_trigger() {
	difference() {
		union() {
			// catch arm
			linear_extrude(height=post_thickness)
				polygon([
						[0, 0],
						[0, trigger_catch_r + trigger_catch_lever_h],
						[-catch_w, trigger_catch_r + trigger_catch_lever_h],
						[-trigger_catch_r, 0],
						[0, 0]
					]);

			// trigger cylinder
			cylinder(post_thickness, trigger_catch_r, trigger_catch_r, [0, 0, 0]);

			// trigger
			linear_extrude(height=post_thickness)
				polygon([[trigger_catch_r, 0],
						[-wall_thickness, -trigger_top_h],
						[-trigger_bottom_w - trigger_bottom_w - wall_thickness, 
								-trigger_top_h - trigger_bottom_h - wall_thickness],
						[-trigger_bottom_w - trigger_bottom_w - wall_thickness, 
								-trigger_top_h - trigger_bottom_h - wall_thickness],
						[-trigger_bottom_w - trigger_bottom_w - wall_thickness, 
								-trigger_top_h - trigger_bottom_h],
						[-trigger_bottom_w - wall_thickness, -trigger_top_h],
						[-trigger_catch_r, 0]
					]);
		}

		// cut pin hole
		translate([0, 0, -0.5])
			cylinder(post_thickness + 1, pin_r + loose_padding, 
					pin_r + loose_padding, [0, 0, 0]);
	};
};

module make_pin_cutter(height) {
	rotate([0, 0, -45])
		difference() {
			// shaft
			cylinder(height, pin_cutter_r, pin_cutter_r, [0, 0, 0]);

			// cut flat side
			translate([-pin_r, pin_flat_trim_y_offset - padding, -0.5])
				cube([2 * pin_r, pin_flat_trim_h, height + 1]);
		};
};

module make_pin() {
	difference() {
		union() {
			translate([0, pin_h / 2.0, pin_r - (pin_flat_ratio * pin_r)])
				rotate([90, 0, 0])
					difference() {
						// shaft
						cylinder(pin_h, pin_r, pin_r, [0, 0, 0]);

						// cut flat side
						translate([-pin_r, pin_flat_trim_y_offset, -0.5])
							cube([2 * pin_r, pin_flat_trim_h, pin_h + 1]);
					}

			// pin end
			translate([0, -(pin_h / 2.0) + pin_end_h, 0])
				make_pin_end();

			// pin end
			translate([0, (pin_h / 2.0) - pin_end_h, 0])
				rotate([0, 0, 180])
					make_pin_end();
		}

		// cut notch
		translate([0, (pin_h / 2.0) - pin_notch_h, 0])
			make_pin_notch_cutter();

		// cut notch
		translate([0, -(pin_h / 2.0) + pin_notch_h, 0])
			rotate([0, 0, 180])
				make_pin_notch_cutter();

		// flatten pin end top
		translate([-(pin_r + pin_lip_w), (pin_h / 2.0) - padding - pin_end_h, 
				wall_thickness])
			cube([2 * (pin_r + pin_lip_w), pin_end_h + padding + 1, 
					pin_r + pin_lip_w]);

		// flatten pin end top
		translate([-(pin_r + pin_lip_w), -(pin_h / 2.0) - 1, 
				wall_thickness])
			cube([2 * (pin_r + pin_lip_w), pin_end_h + padding + 1, 
					pin_r + pin_lip_w]);
	};
};

module make_pin_notch_cutter() {
	translate([0, pin_notch_w / 2.0, -0.5])
		union() {
			translate([-pin_notch_w / 2.0, 0, 0])
				cube([pin_notch_w, pin_notch_h - (pin_notch_w / 2.0) + 0.1, 
						2 * (pin_r + pin_lip_w) + 1]);

			cylinder(2 * (pin_r + pin_lip_w) + 1, pin_notch_w / 2.0, 
					pin_notch_w / 2.0, [0, 0, 0]);
		};
};

module make_pin_end() {
	translate([0, 0, pin_r - (pin_flat_ratio * pin_r)])
		rotate([90, 0, 0])
			difference() {
				union() {
					// taper
					translate([0, 0, pin_lip_h])
						cylinder(pin_taper_h, pin_r + pin_lip_w, pin_r, [0, 0, 0]);

					// lip
					cylinder(pin_lip_h, pin_r + pin_lip_w, pin_r + pin_lip_w, [0, 0, 0]);
				}

				// cut flat side
				translate([-(pin_r + pin_lip_w), pin_flat_trim_y_offset, -0.5])
					cube([2 * (pin_r + pin_lip_w), pin_flat_trim_h, pin_end_h + 1]);
			};
};

module make_trigger_wheel() {
	union() {
		difference() {
			union() {
				// trigger wheel catch
				difference() {
					cylinder(post_thickness, trigger_wheel_catch_r, 
							trigger_wheel_catch_r, [0, 0, 0]);
		
					translate([0, -trigger_wheel_catch_r, -0.5])
						cube([trigger_wheel_catch_r, 2 * trigger_wheel_catch_r, 
							post_thickness + 1]);

					translate([-trigger_wheel_catch_r, -trigger_wheel_catch_r, -0.5])
						cube([trigger_wheel_catch_r + 0.5, trigger_wheel_catch_r, 
								post_thickness + 1]);
				}
					
				// main trigger wheel cylinder
				cylinder(post_thickness, trigger_wheel_r, trigger_wheel_r, [0, 0, 0]);
			}
		
			// cut band post
			translate([0, trigger_wheel_catch_r - band_post_h, -0.5])
				cube([trigger_wheel_r, band_post_h, post_thickness + 1]);

			// cut pin hole
			translate([0, 0, -0.5])
				cylinder(post_thickness + 1, pin_r + loose_padding, 
						pin_r + loose_padding, [0, 0, 0]);
		}

		// cocking lever
		linear_extrude(height=post_thickness)
			polygon([
				[pin_r + loose_padding, 0],
				[pin_r + loose_padding, trigger_wheel_r - wall_thickness],
				[trigger_wheel_r + cocker_l, trigger_wheel_r + wall_thickness],
				[trigger_wheel_r + cocker_l, trigger_wheel_r],
				[trigger_wheel_r, 0]
			]);
	};
};

module make_angle_cutter(height, width) {
	rotate([0, -45, 0])
		cube([(sqrt(2) / 2.0) * width, height, (sqrt(2) / 2.0) * width]);
};
