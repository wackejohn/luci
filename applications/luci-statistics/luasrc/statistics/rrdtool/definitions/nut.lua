--[[

Luci statistics - ups plugin diagram definition
Copyright © 2008 Freifunk Leipzig / Jo-Philipp Wich <xm@leipzig.freifunk.net>
Copyright © 2012 David Woodhouse <dwmw2@infradead.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

]]--


module("luci.statistics.rrdtool.definitions.nut",package.seeall)

function rrdargs( graph, plugin, plugin_instance, dtype )

	local voltages = {
		title = "%H: Voltages on UPS \"%pi\"",
		vlabel = "V",
		number_format = "%5.1lfV",
		data = {
			instances = {
				voltage = { "battery", "input", "output" }
			},

			options = {
				voltage_output  = { color = "00e000", title = "Output voltage", noarea=true, overlay=true },
				voltage_battery = { color = "0000ff", title = "Battery voltage", noarea=true, overlay=true },
				voltage_input   = { color = "ffb000", title = "Input voltage", noarea=true, overlay=true }
			}
		}
	}

	local currents = {
		title = "%H: Current on UPS \"%pi\"",
		vlabel = "A",
		number_format = "%5.3lfA",
		data = {
			instances = {
				current = { "battery", "output" }
			},

			options = {
				current_output  = { color = "00e000", title = "Output current", noarea=true, overlay=true },
				current_battery = { color = "0000ff", title = "Battery current", noarea=true, overlay=true },
			}
		}
	}

	local percentage = {
		title = "%H: Battery charge on UPS \"%pi\"",
		vlabel = "Percent",
		number_format = "%5.1lf%%",
		data = {
		        sources = {
				percent = { "percent" }
			},
			instances = {
				percent = "charge"
			},
			options = {
				percent_charge = { color = "00ff00", title = "Charge level"  }
			}
		}
	}

	-- Note: This is in ISO8859-1 for rrdtool. Welcome to the 20th century.
	local temperature = {
		title = "%H: Battery temperature on UPS \"%pi\"",
		vlabel = "\176C",
		number_format = "%5.1lf\176C",
		data = {
			instances = {
				temperature = "battery"
			},

			options = {
				temperature_battery = { color = "ffb000", title = "Battery temperature" }
			}
		}
	}

	local timeleft = {
		title = "%H: Time left on UPS \"%pi\"",
		vlabel = "Minutes",
		number_format = "%.1lfm",
		data = {
			sources = {
				timeleft = { "timeleft" }
			},
			instances = {
				timeleft = { "battery" }
			},
			options = {
				timeleft_battery = { color = "0000ff", title = "Time left", transform_rpn = "60,/" }
			}
		}
	}

	return { voltages, currents, percentage, temperature, timeleft }
end
