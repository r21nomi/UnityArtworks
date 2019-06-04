using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    public GameObject  target;
    public float rotateSpeed = 10;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    private float r = 0;
    
    // Update is called once per frame
    void Update()
    {

        r += Time.deltaTime * rotateSpeed;

        this.transform.RotateAround
        ( 
            target.transform.position, 
            Vector3.up, 
            r
        );
    }
}
