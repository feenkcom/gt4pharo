"
I am announced by {{gtClass:GtPharoRenameVariableModel}} when a rename should be cancelled, e.g., when a user presses Escape in {{gtClass:GtPharoRenameVariableEditorElement}}. {{gtClass:GtPharoRenameVariableCoderController}} reacts by uninstalling itself.
"
Class {
	#name : #GtPharoRenameVariableCancelRequested,
	#superclass : #GtPharoRenameVariableModelAnnouncement,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}
