function SendTCPtext
{
    # Usage
    # Send TCP Message to EndPointAddr IPAddress at specific port
    # 1. load function file into powershell (:> prompt symbol) :>. ./SendTCPtext.ps1
    # 2. Execute Function :>SendTCPtext $ipAddress $Port "Message"
    # Example. :>SendTCPtext 127.0.0.1 8888 "test Message"

    Param ( [string] $EndPointAddr,
            [int] $Port,
            [string] $Message
    )

    # Parsing Target IP Address and Port Number
    $IP = [System.Net.Dns]::GetHostAddresses($EndPointAddr)
    $Address = [System.Net.IPAddress]::Parse($IP)

    # TCP Socket Object
    $Socket = New-Object System.Net.Sockets.TCPClient($Address,$Port)

    # Setup socket stream wrtier object
    $Stream = $Socket.GetStream()
    $Writer = New-Object System.IO.StreamWriter($Stream)

    # Write Message to stream writer
    $Message | % {
        $Writer.WriteLine($_)
        $Writer.Flush()
    }

    # Close connection and stream
    $Stream.Close()
    $Socket.Close()
}
