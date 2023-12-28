
case $1 in
    cpu)
        case $2 in
            getinfo)
                lscpu
                ;;
            *)
                echo "Unknown cpu command: $2"
                ;;
        esac
        ;;
    memory)
        case $2 in
            getinfo)
                free -m
                ;;
            *)
                echo "Unknown memory command: $2"
                ;;
        esac
        ;;
    user)
        case $2 in
            create)
                if [ -n "$3" ]; then
                    useradd "$3"
                    echo "User $3 created successfully."
                else
                    echo "Username not provided."
                fi
                ;;
            list)
                if [ "$3" == "--sudo-only" ]; then
                    grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' '\n'
                else
                    getent passwd | cut -d: -f1
                fi
                ;;
            *)
                echo "Unknown user command: $2"
                ;;
        esac
        ;;
    file)
        case $2 in
            getinfo)
                if [ -n "$3" ]; then
                    filename="$3"
                    
                    stat --printf="File: %n\nAccess: %a\nSize(B): %s\nOwner: %U\nModify: %y\n" "$filename"
                else
                    echo "File name not provided."
                fi
                ;;
            *)
                echo "Unknown file command: $2"
                ;;
        esac
        ;;
    --help)
        echo "Help for internsctl..."
        
        ;;
    --version)
        echo "internsctl v0.1.0"
        ;;
    *)
        echo "Unknown command: $1"
        ;;
esac
