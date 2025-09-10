Extension { #name : #RPackage }

{ #category : #'*GToolkit-Pharo-Extensions' }
RPackage >> packageManifestOrNil [
	"Avoid using #definedClasses to create a list of classes only to
	select then the one representing the manifest. The manifest is use 
	to check if the package is deprecated, which in turn can slow down checking
	if class is deprecated.
	Related issue: https://github.com/feenkcom/gtoolkit/issues/4369"
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [ 
			self definedClasses
				detect: [ :each | each isManifest ]
				ifNone: [ nil ] ] 
		forPharo11: [
			self gtDefinedClassesWithPossibleDuplicatesDo: [:aClass|
				aClass  isManifest ifTrue: [ ^ aClass ] ].
			nil]
]
