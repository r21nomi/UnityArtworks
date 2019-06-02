using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    private float x;

    // Update is called once per frame
    void Update()
    {
        x += Time.deltaTime * 0.05f;
        this.transform.Rotate(0.0f, x, 0.0f);
    }
}
