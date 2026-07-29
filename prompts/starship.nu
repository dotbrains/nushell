const starship_init = if ("~/.cache/starship/init.nu" | path expand | path exists) {
    "~/.cache/starship/init.nu"
} else {
    null
}
source $starship_init
