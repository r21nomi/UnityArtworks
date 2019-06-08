using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{

    public GameObject target;
    private float r = 0;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        r = Time.deltaTime * 40;
        
        this.transform.RotateAround
        ( 
            target.transform.position, 
            Vector3.up, 
            r
        );
    }
}
