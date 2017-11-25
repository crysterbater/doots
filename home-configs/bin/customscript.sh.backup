"name": "CustomScript",
            "type": "extensions",
            "location": "[resourceGroup().location]",
            "apiVersion": "2016-03-30",
            "dependsOn": [
              "[resourceId('Microsoft.Compute/virtualMachines', variables('vmName'))]"
            ],
            "tags": {
              "displayName": "CustomScript"
            },
            "properties": {
              "publisher": "Microsoft.Azure.Extensions",
              "type": "CustomScript",
              "typeHandlerVersion": "2.0",
              "autoUpgradeMinorVersion": true,
              "settings": {
                "fileUris": [
                  "[concat(parameters('_artifactsLocation'), '/', 'autopart.sh', parameters('_artifactsLocationSasToken'))]",
                  "[concat(parameters('_artifactsLocation'), '/', 'copy_media.sh', parameters('_artifactsLocationSasToken'))]"

                ],
                "commandToExecute": "[concat('bash mount_shares.sh ',parameters('dataDirPath'),' ',parameters('dataDirUsername'),' ',parameters('dataDirPassword'))]"
              }
}
