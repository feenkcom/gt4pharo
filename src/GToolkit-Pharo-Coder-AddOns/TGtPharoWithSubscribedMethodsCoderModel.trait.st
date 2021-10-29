Trait {
	#name : #TGtPharoWithSubscribedMethodsCoderModel,
	#traits : 'TGtPharoWithMethodsCoderModel',
	#classTraits : 'TGtPharoWithMethodsCoderModel classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> notifyCodersCoderChanged [

	"Notify one or more method coders changed"
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> onCodersCoderAdded: aGtCodersCoderAdded [

	"Handle coder added announcement"
	
	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> onCodersCoderRemoved: aGtCodersCoderRemoved [

	"Handle coder removed announcement"

	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> onCodersCoderSourceCodeChanged: aGtCoderSourceCodeChanged [

	"Handle method coder source code changes"

	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> onCodersCodersChanged: aGtCodersCodersChanged [

	"Handle coders changed (added and/or removed) announcement"

	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> onMethodsCoderModelChanged [

	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> subscribeExtraToCodersCoder: aMethodCoder [ 

	"Classes (my users) may subscribe to additional events."
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> subscribeToCodersCoder: aMethodCoder [

	aMethodCoder weak
		when: GtCoderSourceCodeChanged
		send: #onCodersCoderSourceCodeChanged:
		to: self.

	self subscribeExtraToCodersCoder: aMethodCoder
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> subscribeToCodersCoderAdded: anAnnouncement [

	self subscribeToCodersCoder: anAnnouncement coder
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> subscribeToMethodsCoderModel [

	self methodsCoderModel weak
		when: GtCodersCoderAdded
		send: #subscribeToCodersCoderAdded:
		to: self;
		when: GtCodersCoderRemoved
		send: #unsubscribeFromCodersCoderRemoved:
		to: self;
		when: GtCodersCodersChanged
		send: #updateSubscriptionsOnCodersCodersChanged:
		to: self;
		when: GtCodersCoderAdded send: #onCodersCoderAdded: to: self;
		when: GtCodersCoderRemoved send: #onCodersCoderRemoved: to: self;
		when: GtCodersCodersChanged send: #onCodersCodersChanged: to: self.
		
	self methodsCoderModel coders do: [ :eachMethodCoder | 
		self subscribeToCodersCoder: eachMethodCoder
	]
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> unsubscribeExtraToCodersCoder: aMethodCoder [

	"Classes (my users) may subscribe to additional events."	
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> unsubscribeFromCodersCoder: aMethodCoder [

	aMethodCoder unsubscribe: self.
	
	self unsubscribeExtraToCodersCoder: aMethodCoder
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> unsubscribeFromCodersCoderRemoved: aGtCodersCoderRemoved [

	self unsubscribeFromCodersCoder: aGtCodersCoderRemoved coder
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> unsubscribeFromMethodsCoderModel [

	self methodsCoderModel unsubscribe: self
]

{ #category : #'api - methods coder model' }
TGtPharoWithSubscribedMethodsCoderModel >> updateSubscriptionsOnCodersCodersChanged: aGtCodersCodersChanged [

	aGtCodersCodersChanged removedCoders do: [ :eachMethodCoder | 
		self unsubscribeFromCodersCoder: eachMethodCoder ].

	aGtCodersCodersChanged addedCoders do: [ :eachMethodCoder | 
		self subscribeToCodersCoder: eachMethodCoder ]
]
