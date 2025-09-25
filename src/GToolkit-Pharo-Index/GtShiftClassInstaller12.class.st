Class {
	#name : #GtShiftClassInstaller12,
	#superclass : #ShiftClassInstaller,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #initialization }
GtShiftClassInstaller12 >> initialize [

	super initialize.
	builder := GtShiftClassBuilder12 new
]

{ #category : #building }
GtShiftClassInstaller12 >> make [
	| newClass |

	[
		newClass := builder build.

		self installInEnvironment: newClass.

		self installSubclassInSuperclass: newClass.

		builder builderEnhancer beforeMigratingClass: builder installer: self.

		builder builderEnhancer migrateToClass: newClass installer: self.

		builder builderEnhancer afterMigratingClass: builder installer: self.

		builder builderEnhancer propagateChangesToRelatedClasses: newClass builder: builder.
		
		"Add this to the superclass implementation"
		SystemAnnouncer uniqueInstance
			announce: (GtClassRecompiled new classAffected: newClass)
	] on: ShNoChangesInClass do:[
		"If there are no changes in the building, I am not building or replacing nothing"
		newClass := self oldClass.
	].

	self updatePackage: newClass.
	self comment: newClass.

	self notifyChanges.

	^ newClass
]
