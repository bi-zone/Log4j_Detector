rule log4j_memory
{
	meta:
		author = "BI.ZONE"
		version = "0.12"
		description = "Process memory signatures for Log4j"
		license = "Just do whatever you want"

	strings:
		$s_1 = "\\log4j\\core\\" wide
		$s_2 = "\\apache\\logging\\log4j\\" wide
		$s_3 = "/apache/logging/log4j/" ascii
		$s_4 = "/log4j/core/config/" ascii
		$s_5 = "org.apache.logging.log4j." ascii
		$s_6 = "org.apache.log4j" ascii
		$s_7 = "org/apache/log4j/" ascii
		$s_8 = "log4j:message" ascii

		$a_1 = "Log4j appears to be running in a Servlet environment" ascii
		$a_2 = "this tool is superseded by the annotation processor included in log4j-core" ascii
		$a_3 = "Error parsing Log4j schema" ascii
		$a_4 = "org.apache.logging.log4j2:type=%s,component=Loggers,name=%s,subtype=RingBuffer" ascii
		$a_5 = "log4j:ERROR" ascii
		$a_6 = "log4j error:" ascii
		$a_7 = "$log4j$spi$ErrorHandler" ascii

		$this_rule = "we_dont_want_to_detect_this_rule_in_memory" ascii

	condition:
		2 of ($s_*) and 1 of ($a_*) and (not $this_rule)
}
