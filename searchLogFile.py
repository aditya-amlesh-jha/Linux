import os
import glob


def search_for_error(log_file, key_word):
    print(f"Searching for keyword {key_word} in {log_file}:")
    try:
        with open(log_file, "r") as file:
            for line in file:
                if "error" in line.lower():
                    print(line.strip())
    except IOError:
        print(f"Error reading file: {log_file}")
    except Exception as e:
        print("Encountered exception {e.message}")
    finally:
        for _ in range(20):
            print("-", end="")
        print()


def search_directory(root_dir, key_word):
    log_files = glob.glob(os.path.join(root_dir, "*.log"))
    recent_log_files = sorted(
        log_files, key=lambda x: os.path.getmtime(x), reverse=True
    )[:3]

    for log_file in recent_log_files:
        search_for_error(log_file,key_word)


def main():
    root_dir = input("Enter the base directory: ")

    if not os.path.exists(root_dir) or not os.path.isdir(root_dir):
        print(f"Directory {root_dir} does not exist, exiting.....")
        exit(1)

    key_word = input("Enter the keyword for searching: ")
    
    search_directory(root_dir,key_word)

    for sub_dir in [d for d in os.listdir(root_dir) if os.path.isdir(os.path.join(root_dir,d))]:
        search_directory(os.path.join(root_dir,sub_dir),key_word)


if __name__ == "__main__":
    main()
