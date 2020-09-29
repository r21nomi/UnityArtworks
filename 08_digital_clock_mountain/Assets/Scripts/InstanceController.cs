using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstanceController : MonoBehaviour
{
    public GameObject Target;
    private int count = 100;
    private int range = 3;

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine("Create");
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator Create()
    {
        for (int i = 0; i < count; i++)
        {
            Instantiate(
                Target,
                new Vector3(Random.Range(-range, range), 15.0f + Random.Range(0f, 5f), Random.Range(-range, range)),
                Quaternion.Euler(0, Random.Range(-180, 180), Random.Range(-180, 180))
            );
            yield return new WaitForSeconds(0.15f);
        }
    }
}
