<#
.description
    Take a supplied HEX encoded string and converts it to decimal string.
#>
param (
    # Source HEX
    [Parameter(Mandatory=$true,Position=1)]
    [String]
    $hex_string
)

# Convert the src string into an array of HEX values.
[string[]] $hex_key = $hex_string.Trim().Split(" ")

# Initialize the result string to empty
[String] $res_string = ""

# Initialize the part string to 0x. 
# This is important because when the string value is cast to an [uint32] this
# specifies the source string is HEX encoded.
[string] $part="0x"

for ( $i=0; $i -le $hex_key.Length; $i++) {

    # The '00' value needs to be processed individually all remaining are
    # processed as pairs so we create brakes whenever the number of HEX values
    # divided by 2 has a remainder of 1.
    if (($i % 2) -eq 1) {

        # After each pair of values has been added to $part we need to convert
        # them to a decimal value and add them to the $res_string.
        # Also insure that the resulting string is always 5 digits by
        # prepending 0s to the value when needed.
        $res_string += '{0:d5}' -f ([uint32]$part)

        # Handle the "-" used to seaparte decimal values
        if ($i -ne $hex_key.Length) {
            $res_string += "-"
        }

        # Re-initialize the $part variable for next value.
        $part="0x"
    }

    # Append the current HEX value to the current $part since they are converted
    # in pairs.
    $part += $hex_key[$i]
}

# Print the result.
write-host $res_string

