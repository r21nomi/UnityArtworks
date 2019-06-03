using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    private float r;

    // Update is called once per frame
    void Update()
    {
        r = Time.deltaTime * 20.5f;
        this.transform.Rotate(r, r, r);
    }
}
