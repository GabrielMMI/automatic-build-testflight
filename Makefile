.SILENT:increment_build_pf
.SILENT:increment_build_pj
.SILENT:clean_project_pf
.SILENT:clean_project_pj
.SILENT:clean_archive_folder_pf
.SILENT:clean_archive_folder_pj
.SILENT:archive_pf
.SILENT:archive_pj
.SILENT:export_ipa_pf
.SILENT:export_ipa_pj
.SILENT:publish_app_pf
.SILENT:publish_app_pj

.SILENT:testflight_pf
.SILENT:testflight_pj
.SILENT:testeflight_pf_pj

ALTOOL_PATH = /Applications/Xcode.app/Contents/Developer/usr/bin

PF_PLIST = app/CaixaMais/CaixaMais/app/pf/PF-Info.plist
PF_SCHEME = DEV_CaixaMais

PJ_PLIST = app/CaixaMais/CaixaMais/app/pj/PJ-Info.plist
PJ_SCHEME = DEV_CaixaMaisEmpresa

PROJECT_PATH = app/CaixaMais
PROJECT_NAME = CaixaMais.xcworkspace

increment_build_pf: 
	.scripts/increment-build ${PF_SCHEME} ${PF_PLIST} $(buildPF)

increment_build_pj:
	.scripts/increment-build ${PJ_SCHEME} ${PJ_PLIST} $(buildPJ)

clean_project_pf:
	xcodebuild -workspace ${PROJECT_PATH}/${PROJECT_NAME} -scheme ${PF_SCHEME} -sdk iphoneos -configuration Debug clean

clean_project_pj:
	xcodebuild -workspace ${PROJECT_PATH}/${PROJECT_NAME} -scheme ${PJ_SCHEME} -sdk iphoneos -configuration Debug clean

clean_archive_folder_pf:
	rm -R .archives/buildPF

clean_archive_folder_pj:
	rm -R .archives/buildPJ

archive_pf:
	make -i clean_archive_folder_pf
	xcodebuild -workspace ${PROJECT_PATH}/${PROJECT_NAME} -scheme ${PF_SCHEME} -sdk iphoneos -configuration Debug archive -archivePath .archives/buildPF/${PF_SCHEME}.xcarchive

archive_pj:
	make -i clean_archive_folder_pj
	xcodebuild -workspace ${PROJECT_PATH}/${PROJECT_NAME} -scheme ${PJ_SCHEME} -sdk iphoneos -configuration Debug archive -archivePath .archives/buildPJ/${PJ_SCHEME}.xcarchive

export_ipa_pf:
	xcodebuild -exportArchive -archivePath .archives/buildPF/${PF_SCHEME}.xcarchive -exportOptionsPlist ${PROJECT_PATH}/exportOptions.plist -exportPath .archives/buildPF -allowProvisioningUpdates

export_ipa_pj:
	xcodebuild -exportArchive -archivePath .archives/buildPJ/${PJ_SCHEME}.xcarchive -exportOptionsPlist ${PROJECT_PATH}/exportOptions.plist -exportPath .archives/buildPJ -allowProvisioningUpdates

publish_app_pf:
	xcrun altool --upload-app --type ios --file .archives/buildPF/CaixaMaisDev.ipa --username mobiledeveloper@foton.la --password kdkr-arle-tfii-tumt

publish_app_pj:
	xcrun altool --upload-app --type ios --file .archives/buildPJ/CaixaMais\ Empresa\ Dev.ipa --username mobiledeveloper@foton.la --password kdkr-arle-tfii-tumt
	osascript -e 'tell app "System Events" to display dialog "Caixa+ Empresa Gerado"'

# Gerando a build PF
testflight_pf: 
	make increment_build_pf buildPF=$(buildPF)
	make clean_project_pf
	make archive_pf
	make export_ipa_pf
	make publish_app_pf
	osascript -e 'tell app "System Events" to display dialog "Builds Geradas:\nCaixa+"'

# Gerando a build PJ
testflight_pj:
	make increment_build_pj buildPF=$(buildPJ)
	make clean_project_pj
	make archive_pj
	make export_ipa_pj
	make publish_app_pj
	osascript -e 'tell app "System Events" to display dialog "Builds Geradas:\nCaixa+ Empresa"'

# Gerando PF e PJ
testeflight_pf_pj:
	make increment_build_pf buildPF=$(buildPF)
	make clean_project_pf
	make archive_pf
	make export_ipa_pf
	make publish_app_pf
	make increment_build_pj buildPF=$(buildPJ)
	make clean_project_pj
	make archive_pj
	make export_ipa_pj
	make publish_app_pj
	osascript -e 'tell app "System Events" to display dialog "Builds Geradas:\nCaixa+\n Caixa+ Empresa"'
