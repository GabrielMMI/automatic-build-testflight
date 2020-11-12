.SILENT:

PLIST = [path_to_plist]
SCHEME = [scheme_name]

PROJECT_PATH = [path_from_this_folder_to_plist]
PROJECT_NAME = [project_name]
PROJECT_DISPLAY_NAME = [project_display_name]

EXPORT_OPTIONS_PLIST = [export_options_name].plist

ARCHIVE_PATH = .archives
ARCHIVE_SCHEME_FOLDER = [name_of_folder]

USERNAME = [apple_id]
PASSWORD = [app_specific_password]

RED=`tput setaf 1`
GREEN=\033[1;32m
YELLOW=`tput setaf 3`
BLINK= `tput blink`
RESET=`tput sgr0`

# Command to automatically increment the build number
# If the build number is passed (e.g. build = 1), the number will NOT be incremented
increment_build: --print_build_number --print_increment
	.scripts/increment-build ${PROJECT_PATH}/${PROJECT_NAME} ${SCHEME} ${PLIST} $(build)

# Command to clear the project
clean_project: --print_build_number --print_clean_project
	xcodebuild -workspace ${PROJECT_PATH}/${PROJECT_NAME}.xcworkspace -scheme ${SCHEME} -sdk iphoneos -configuration Debug clean

# Command to clear the archive folder
clean_archive_folder:
	rm -R .archives/buildPF

# Command to archive the project and generate the .xcarchive file
archive: --print_build_number --print_archive
	make -i clean_archive_folder_pf
	xcodebuild -workspace ${PROJECT_PATH}/${PROJECT_NAME}.xcworkspace -scheme ${SCHEME} -sdk iphoneos -configuration Debug archive -archivePath ${ARCHIVE_PATH}/${ARCHIVE_SCHEME_FOLDER}/${SCHEME}.xcarchive

# Command to export the .ipa file from .xcarchive
export_ipa: --print_build_number --print_ipa
	xcodebuild -exportArchive -archivePath ${ARCHIVE_PATH}/${ARCHIVE_SCHEME_FOLDER}/${SCHEME}.xcarchive -exportOptionsPlist ${PROJECT_PATH}/${EXPORT_OPTIONS_PLIST}.plist -exportPath ${ARCHIVE_PATH}/${ARCHIVE_SCHEME_FOLDER} -allowProvisioningUpdates

# Command to send the .ipa file to the App Store, automatically releasing it for Testflight
publish_app: --print_build_number --print_testflight
	xcrun altool --upload-app --type ios --file ${ARCHIVE_PATH}/${ARCHIVE_SCHEME_FOLDER}/${PROJECT_DISPLAY_NAME}.ipa --username ${USERNAME} --password ${PASSWORD}

# Command to generate all process to testflight
testflight:
	make increment_build build=$(build)
	make clean_project
	make archive
	make export_ipa
	make publish_app
	make print_logo
	.scripts/print-build-number ${PROJECT_PATH}/${PROJECT_NAME} ${SCHEME} ${PLIST} $(build)
	make print_success
	osascript -e 'tell app "System Events" to display dialog "Builds Geradas:\nCaixa+"'

# -------------------- Visual terminal commands --------------------

# Command to display the app logo on the terminal
print_logo:
	echo "${YELLOW}----------------------------------------------"    
	echo "  _                       "
	echo " | |                      "
	echo " | |     ___   __ _  ___  "
	echo " | |    / _ \ / _\` |/ _ \ "
	echo " | |___| (_) | (_| | (_) |"
	echo " |______\___/ \__, |\___/ "
	echo "               __/ |      "
	echo "              |___/       "
	echo ""
	echo "----------------------------------------------${RESET}"

# Command to show the scheme and the build number being generated
--print_build_number: print_logo
	.scripts/print-build-number ${PROJECT_PATH}/${PROJECT_NAME} ${SCHEME} ${PLIST} $(build)

# Command to show the step of increasing the build number
--print_increment:
	echo "${YELLOW}##############################################"
	echo "${GREEN}Incrementar Build ${BLINK}(Processando)${RESET}"
	echo "${RED}Limpar projeto"
	echo "Limpar diretório de archives"
	echo "Archive"
	echo "Gerar .ipa"
	echo "Publicar App no Testflight${RESET}"
	echo "${YELLOW}##############################################"
	echo "----------------------------------------------${RESET}"

# Command to show the step of cleaning the project
--print_clean_project:
	echo "${YELLOW}##############################################"
	echo "${GREEN}Incrementar Build (Sucesso)"
	echo "Limpar projeto ${BLINK}(Processando)${RESET}"
	echo "${RED}Limpar diretório de archives"
	echo "Archive"
	echo "Gerar .ipa"
	echo "Publicar App no Testflight${RESET}"
	echo "${YELLOW}##############################################"
	echo "----------------------------------------------${RESET}"

# Command to show the step of generating the archive
--print_archive:
	echo "${YELLOW}##############################################"
	echo "${GREEN}Incrementar Build (Sucesso)"
	echo "Limpar projeto (Sucesso)"
	echo "Limpar diretório de archives (Sucesso)"
	echo "Archive ${BLINK}(Processando)${RESET}"
	echo "${RED}Gerar .ipa"
	echo "Publicar App no Testflight${RESET}"
	echo "${YELLOW}##############################################"
	echo "----------------------------------------------${RESET}"

# Command to show the step of exporting the .ipa file
--print_ipa:
	echo "${YELLOW}##############################################"
	echo "${GREEN}Incrementar Build (Sucesso)"
	echo "Limpar projeto (Sucesso)"
	echo "Limpar diretório de archives (Sucesso)"
	echo "Archive (Sucesso)"
	echo "Gerar .ipa ${BLINK}(Processando)${RESET}"
	echo "${RED}Publicar App no Testflight${RESET}"
	echo "${YELLOW}##############################################"
	echo "----------------------------------------------${RESET}"

# Command to show the step of sending the .ipa to Testflight
--print_testflight:
	echo "${YELLOW}##############################################"
	echo "${GREEN}Incrementar Build (Sucesso)"
	echo "Limpar projeto (Sucesso)"
	echo "Limpar diretório de archives (Sucesso)"
	echo "Archive (Sucesso)"
	echo "Gerar .ipa (Sucesso)"
	echo "Publicar App no Testflight ${BLINK}(Processando)${RESET}"
	echo "${YELLOW}##############################################"
	echo "----------------------------------------------${RESET}"

# Command to show the step that the testflight build generation process was successfully completed
print_success:
	echo "${YELLOW}##############################################"
	echo "${GREEN}Incrementar Build (Sucesso)"
	echo "Limpar projeto (Sucesso)"
	echo "Limpar diretório de archives (Sucesso)"
	echo "Archive (Sucesso)"
	echo "Gerar .ipa (Sucesso)"
	echo "Publicar App no Testflight (Sucesso)${RESET}"
	echo "${YELLOW}##############################################"
	echo "----------------------------------------------${RESET}"
