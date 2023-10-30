Class {
	#name : #GtShiftClassInstaller,
	#superclass : #ShiftClassInstaller,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtShiftClassInstaller >> make [
	| newClass |

	self lookupOldClass.

	[	
		builder oldClass: oldClass.
		self copyClassSlotsFromExistingClass.
		newClass := builder build.

		self installInEnvironment: newClass.

		self installSubclassInSuperclass: newClass.
	
		builder builderEnhancer beforeMigratingClass: builder installer: self.

		builder builderEnhancer migrateToClass: newClass installer: self.

		builder builderEnhancer afterMigratingClass: builder installer: self.	

		builder builderEnhancer propagateChangesToRelatedClasses: newClass installer: self.
		"Add this to the superclass implementation"
		SystemAnnouncer uniqueInstance
			announce: (GtClassRecompiled new classAffected: newClass) .
	] on: ShNoChangesInClass do:[
		"If there are no changes in the building, I am not building or replacing nothing"
		newClass := oldClass.
	].

	self fixSlotScope: newClass.
	self fixSlotScope: newClass class.

	self recategorize: newClass to: builder category.
	self comment: newClass.

	self notifyChanges.

	^ newClass
]
